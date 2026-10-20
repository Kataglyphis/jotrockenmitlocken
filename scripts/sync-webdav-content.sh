#!/usr/bin/env bash
# sync-webdav-content.sh - pulls the site content into LOCAL_ASSETS_FOLDER; the four WEBDAV_* credentials come via the environment, never argv.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Only the image's pinned CPython (owner, 2026-10-20): on a bare host uv would download an interpreter.
if [ -z "${PYTHON_MAJOR_MINOR:-}" ] || ! command -v "python${PYTHON_MAJOR_MINOR}" >/dev/null 2>&1; then
  printf 'sync-webdav-content.sh runs in the family Linux image (AGENTS.md, section 5)\n' >&2
  exit 2
fi

# shellcheck source=/dev/null
source "${SCRIPT_DIR}/lib/antfrastructure.sh"

# Empty counts as missing (a blank host would ship stale assets); the message names the repository secret.
: "${WEBDAV_HOSTNAME:?set WEBDAV_HOSTNAME (repository secret WEBDAV_HOSTNAME)}"
: "${WEBDAV_USERNAME:?set WEBDAV_USERNAME (repository secret WEBDAV_USERNAME)}"
: "${WEBDAV_PASSWORD:?set WEBDAV_PASSWORD (repository secret WEBDAV_PASSWORD)}"
: "${WEBDAV_REMOTE_BASE_PATH:?set WEBDAV_REMOTE_BASE_PATH (repository secret REMOTE_BASE_PATH)}"

LOCAL_ASSETS_FOLDER="${LOCAL_ASSETS_FOLDER:-assets}"

# In the image, uv_venv_create takes the image's own X.Y with UV_PYTHON_DOWNLOADS=never.
antfrastructure_source linux/scripts/01-core/python_uv.sh
antfrastructure_source linux/scripts/01-core/webdav-download.sh

# webdav_download_tree expects the venv at the repo root, and the destination is repo-relative.
cd "$KATAGLYPHIS_REPO_ROOT"

uv_ensure_installed
uv_venv_create "${KATAGLYPHIS_REPO_ROOT}/.venv" "$(python_pinned_major_minor)"

# No extension filter: the site bundles the whole tree, images included.
webdav_download_tree "${WEBDAV_REMOTE_BASE_PATH}" "${LOCAL_ASSETS_FOLDER}" all
