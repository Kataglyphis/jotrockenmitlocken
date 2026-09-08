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

# uv bootstrap and venv creation are ContainerHub's, not this repo's. What was
# here was a hand-rolled `command -v uv` guard plus a bare `uv venv`; the
# upstream library does both properly and is what BeschleunigerBallett already
# consumes through two thin wrappers of its own. uv_ensure_installed downloads
# the installer TO A FILE rather than piping curl into sh, and verifies it
# against UV_INSTALL_SH_SHA256 from versions.env - a truncated stream cannot
# execute as a partial script. uv_venv_create adds the interpreter-availability
# probe (`uv python install` when python3.14 is not on the box) that the bare
# call did not have: on the hosted runner setup-uv provides uv but nothing
# provides 3.14, so `uv venv --python=3.14` was one upstream image change away
# from a needless red.
containerhub_source linux/scripts/01-core/python_uv.sh

# The venv lives at the repo root because `uv run` discovers .venv from the cwd,
# and download_markdown_files.py is resolved relative to the root too.
cd "$KATAGLYPHIS_REPO_ROOT"

uv_ensure_installed
uv_venv_create "${KATAGLYPHIS_REPO_ROOT}/.venv" "${SYNC_PYTHON_VERSION}"

# --python, spelled out rather than left to .venv discovery, is the one piece
# the upstream library does NOT cover: it owns uv_pip_install_requirements,
# which takes a requirements FILE, and this step installs a git URL instead.
# The pin is copied from that function, whose comment says it is load-bearing
# because uv honours UV_PYTHON over an activated venv and the family image
# exports UV_PYTHON=/opt/venv/bin/python (root-owned, while the container user
# is uid 1001). MEASURED 2026-09-08 in :latest-cross with uv 0.9.x: that no
# longer reproduces - a `.venv` in the cwd wins over UV_PYTHON and the install
# lands locally either way. The pin stays because it names the target instead
# of depending on which of two mechanisms uv currently prefers, and because
# the failure it guards against is a root-owned write, not a red build.
#
# bin/python is the POSIX venv layout; a Git Bash venv carries
# Scripts/python.exe instead. Missing both is a broken venv, and it fails HERE
# by name rather than as a confusing resolver error two commands later.
VENV_PYTHON="${KATAGLYPHIS_REPO_ROOT}/.venv/bin/python"
[ -x "$VENV_PYTHON" ] || VENV_PYTHON="${KATAGLYPHIS_REPO_ROOT}/.venv/Scripts/python.exe"
if [ ! -x "$VENV_PYTHON" ]; then
  echo "Error: no interpreter in ${KATAGLYPHIS_REPO_ROOT}/.venv" >&2
  echo "       (neither bin/python nor Scripts/python.exe) - uv_venv_create" >&2
  echo "       reported success but produced no usable venv." >&2
  exit 1
fi

uv pip install --python "$VENV_PYTHON" git+https://github.com/Kataglyphis/WebDavClient
uv run --python "$VENV_PYTHON" python scripts/download_markdown_files.py \
  "${WEBDAV_HOSTNAME}" \
  "${WEBDAV_USERNAME}" \
  "${WEBDAV_PASSWORD}" \
  "${WEBDAV_REMOTE_BASE_PATH}" \
  "${LOCAL_ASSETS_FOLDER}"
