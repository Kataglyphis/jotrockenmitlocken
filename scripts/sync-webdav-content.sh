#!/usr/bin/env bash
# Pull the site's markdown content off the WebDAV server into the assets folder,
# which is what the Flutter build then bundles.
#
#     WEBDAV_HOSTNAME=... WEBDAV_USERNAME=... WEBDAV_PASSWORD=... \
#     WEBDAV_REMOTE_BASE_PATH=... bash scripts/sync-webdav-content.sh
#
# This is the whole content-sync step, and NONE of it is this repo's code any
# more. It used to be: a local scripts/download_markdown_files.py, and a local
# WEBDAVCLIENT_REF pasted into a `uv pip install git+...` line here. Both are
# gone. ANTfrastructure ships the downloader (01-core/webdav-download.sh and its
# 01-core/download-webdav-files.py,
# third_party/ANTfrastructure/docs/shared-script-libraries.md
# #01-corewebdav-downloadsh) and owns the pin in 01-core/versions.env, so
# "which WebDavClient did this run use" has one answer for the whole fleet
# instead of one per consumer. What is left here is this repo's own policy: WHICH
# secrets, WHICH interpreter, and WHERE the tree lands.
#
# Credentials come through the ENVIRONMENT, not argv, all the way down. In the
# workflow that is the difference between `${{ secrets.WEBDAV_PASSWORD }}` being
# pasted into a shell command line - where a password containing a quote or
# `$(...)` is a quoting bug at best - and being handed to the process as data.
#
# Env:
#   WEBDAV_HOSTNAME, WEBDAV_USERNAME, WEBDAV_PASSWORD, WEBDAV_REMOTE_BASE_PATH
#                        required; empty is an error, not an empty download
#   LOCAL_ASSETS_FOLDER  destination, repo-relative (default: assets)
#   SYNC_PYTHON_VERSION  interpreter uv provisions for the venv (default: 3.14)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# shellcheck source=/dev/null
source "${SCRIPT_DIR}/lib/antfrastructure.sh"

# A missing secret used to reach argparse as "too few arguments", which names
# neither the variable nor the fact that it is a repository secret. Worse, an
# EMPTY one is five arguments and argparse accepts it - the sync would then run
# against a blank host and the build would ship yesterday's assets. Upstream
# checks the three credentials too, but only by variable name; these say which
# repository secret is missing, which is the part a reader cannot look up.
: "${WEBDAV_HOSTNAME:?set WEBDAV_HOSTNAME (repository secret WEBDAV_HOSTNAME)}"
: "${WEBDAV_USERNAME:?set WEBDAV_USERNAME (repository secret WEBDAV_USERNAME)}"
: "${WEBDAV_PASSWORD:?set WEBDAV_PASSWORD (repository secret WEBDAV_PASSWORD)}"
: "${WEBDAV_REMOTE_BASE_PATH:?set WEBDAV_REMOTE_BASE_PATH (repository secret REMOTE_BASE_PATH)}"

LOCAL_ASSETS_FOLDER="${LOCAL_ASSETS_FOLDER:-assets}"
SYNC_PYTHON_VERSION="${SYNC_PYTHON_VERSION:-3.14}"

# uv bootstrap and venv creation are ANTfrastructure's, not this repo's. What was
# here was a hand-rolled `command -v uv` guard plus a bare `uv venv`; the
# upstream library does both properly. uv_ensure_installed downloads the
# installer TO A FILE rather than piping curl into sh, and verifies it against
# UV_INSTALL_SH_SHA256 from versions.env - a truncated stream cannot execute as
# a partial script. uv_venv_create adds the interpreter-availability probe
# (`uv python install` when python3.14 is not on the box) that the bare call did
# not have: on the hosted runner setup-uv provides uv but nothing provides 3.14.
antfrastructure_source linux/scripts/01-core/python_uv.sh
antfrastructure_source linux/scripts/01-core/webdav-download.sh

# The venv lives at the repo root because that is where webdav_download_tree
# looks for it (${KATAGLYPHIS_REPO_ROOT}/.venv), and the destination below is
# repo-relative.
cd "$KATAGLYPHIS_REPO_ROOT"

uv_ensure_installed
uv_venv_create "${KATAGLYPHIS_REPO_ROOT}/.venv" "${SYNC_PYTHON_VERSION}"

# No extension filter: this site bundles the whole tree (markdown, and the
# images the posts reference), so the walk is the client's own
# download_all_files_iterative rather than a per-suffix pass.
webdav_download_tree "${WEBDAV_REMOTE_BASE_PATH}" "${LOCAL_ASSETS_FOLDER}" all
