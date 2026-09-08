#!/usr/bin/env bash
# Pull the site's markdown content off the WebDAV server into the assets folder,
# which is what the Flutter build then bundles.
#
# This is the whole content-sync step: environment bootstrap AND download. The
# download half was already a script (scripts/download_markdown_files.py); the
# bootstrap around it - venv, python version, the WebDavClient install - lived
# only in .github/workflows/dart.yml, so the step could not be reproduced with
# one command outside CI. It can now:
#
#     WEBDAV_HOSTNAME=... WEBDAV_USERNAME=... WEBDAV_PASSWORD=... \
#     WEBDAV_REMOTE_BASE_PATH=... bash scripts/sync-webdav-content.sh
#
# Credentials come through the ENVIRONMENT, not argv. In the workflow that is
# the difference between `${{ secrets.WEBDAV_PASSWORD }}` being pasted into a
# shell command line - where a password containing a quote or `$(...)` is a
# quoting bug at best - and being handed to the process as data. The python
# entry point keeps its positional interface; only this boundary changed.
#
# Env:
#   WEBDAV_HOSTNAME, WEBDAV_USERNAME, WEBDAV_PASSWORD, WEBDAV_REMOTE_BASE_PATH
#                        required; empty is an error, not an empty download
#   LOCAL_ASSETS_FOLDER  destination, repo-relative (default: assets)
#   SYNC_PYTHON_VERSION  interpreter uv provisions for the venv (default: 3.14)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# shellcheck source=/dev/null
source "${SCRIPT_DIR}/lib/containerhub.sh"

# A missing secret used to reach argparse as "too few arguments", which names
# neither the variable nor the fact that it is a repository secret. Worse, an
# EMPTY one is five arguments and argparse accepts it - the sync would then run
# against a blank host and the build would ship yesterday's assets.
: "${WEBDAV_HOSTNAME:?set WEBDAV_HOSTNAME (repository secret WEBDAV_HOSTNAME)}"
: "${WEBDAV_USERNAME:?set WEBDAV_USERNAME (repository secret WEBDAV_USERNAME)}"
: "${WEBDAV_PASSWORD:?set WEBDAV_PASSWORD (repository secret WEBDAV_PASSWORD)}"
: "${WEBDAV_REMOTE_BASE_PATH:?set WEBDAV_REMOTE_BASE_PATH (repository secret REMOTE_BASE_PATH)}"

LOCAL_ASSETS_FOLDER="${LOCAL_ASSETS_FOLDER:-assets}"
SYNC_PYTHON_VERSION="${SYNC_PYTHON_VERSION:-3.14}"

if ! command -v uv >/dev/null 2>&1; then
  echo "Error: uv is not on PATH." >&2
  echo "       CI installs it with astral-sh/setup-uv; locally see https://docs.astral.sh/uv/." >&2
  exit 1
fi

# The venv lives at the repo root because `uv run` discovers .venv from the cwd,
# and download_markdown_files.py is resolved relative to the root too.
cd "$KATAGLYPHIS_REPO_ROOT"

uv venv --python="${SYNC_PYTHON_VERSION}"
uv pip install git+https://github.com/Kataglyphis/WebDavClient
uv run python scripts/download_markdown_files.py \
  "${WEBDAV_HOSTNAME}" \
  "${WEBDAV_USERNAME}" \
  "${WEBDAV_PASSWORD}" \
  "${WEBDAV_REMOTE_BASE_PATH}" \
  "${LOCAL_ASSETS_FOLDER}"
