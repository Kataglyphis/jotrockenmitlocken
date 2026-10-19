#!/usr/bin/env bash
# sync-webdav-content.sh - pulls the site content into LOCAL_ASSETS_FOLDER; the four WEBDAV_* credentials come via the environment, never argv.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# shellcheck source=/dev/null
source "${SCRIPT_DIR}/lib/antfrastructure.sh"

# Empty counts as missing (a blank host would ship stale assets); the message names the repository secret.
: "${WEBDAV_HOSTNAME:?set WEBDAV_HOSTNAME (repository secret WEBDAV_HOSTNAME)}"
: "${WEBDAV_USERNAME:?set WEBDAV_USERNAME (repository secret WEBDAV_USERNAME)}"
: "${WEBDAV_PASSWORD:?set WEBDAV_PASSWORD (repository secret WEBDAV_PASSWORD)}"
: "${WEBDAV_REMOTE_BASE_PATH:?set WEBDAV_REMOTE_BASE_PATH (repository secret REMOTE_BASE_PATH)}"

LOCAL_ASSETS_FOLDER="${LOCAL_ASSETS_FOLDER:-assets}"

# setup-uv provides uv on the runner but no Python, so uv_venv_create installs the hub's pinned X.Y.
antfrastructure_source linux/scripts/01-core/python_uv.sh
antfrastructure_source linux/scripts/01-core/webdav-download.sh
SYNC_PYTHON_VERSION="${SYNC_PYTHON_VERSION:-$(python_pinned_major_minor)}"

# webdav_download_tree expects the venv at the repo root, and the destination is repo-relative.
cd "$KATAGLYPHIS_REPO_ROOT"

uv_ensure_installed
uv_venv_create "${KATAGLYPHIS_REPO_ROOT}/.venv" "${SYNC_PYTHON_VERSION}"

# No extension filter: the site bundles the whole tree, images included.
webdav_download_tree "${WEBDAV_REMOTE_BASE_PATH}" "${LOCAL_ASSETS_FOLDER}" all
