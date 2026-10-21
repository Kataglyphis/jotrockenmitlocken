#!/usr/bin/env bash
# run-nginx-integration-test.sh [--port N] - the smoke test through the shared nginx config (headers, CSP, SPA rewrite); builds first if build/web is missing.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# The submodule path and the not-found guard come from the synced bootstrap.
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/lib/antfrastructure.sh"

BUILD_DIR="${KATAGLYPHIS_REPO_ROOT}/build/web"
if [ ! -f "${BUILD_DIR}/index.html" ]; then
  echo "Build not found. Building..."
  (cd "${KATAGLYPHIS_REPO_ROOT}" && flutter build web --release --wasm --no-tree-shake-icons)
fi

# This app's CSP hosts and shell checks; the harness and its teardown are ANTfrastructure's.
export REQUIRED_CSP_HOSTS="www.gstatic.com fonts.gstatic.com"
export CHECK_LOADING_SHELL=1
antfrastructure_exec linux/webserver/scripts/flutter-nginx-integration-test.sh "${BUILD_DIR}" "$@"
