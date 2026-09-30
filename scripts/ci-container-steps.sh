#!/usr/bin/env bash
# ci-container-steps.sh <phase> - one web.yml step per phase, each in a fresh container, so the prologue re-establishes state.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# The submodule path and the not-found guard come from the synced bootstrap.
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/lib/antfrastructure.sh"

antfrastructure_source linux/scripts/05-frameworks/flutter/lane-prologue.sh
antfrastructure_source linux/scripts/01-core/http-readiness.sh

usage() {
  echo "Usage: $0 <dart-checks|build-web-wasm|smoke-test|build-web-canvaskit|dart-doc>" >&2
}

container_prologue() {
  # flutter_lane_prepare_env returns non-zero rather than exiting, so the exit is spelled here.
  flutter_lane_prepare_env "${FLUTTER_DIR:-/opt/flutter}" || exit 1
  cd "${KATAGLYPHIS_REPO_ROOT}"
}

phase_dart_checks() {
  bash "${KATAGLYPHIS_REPO_ROOT}/scripts/run-dart-checks.sh"
}

phase_build_web_wasm() {
  # Per-user config, so per-container: enable web in the container that builds.
  flutter config --enable-web
  flutter_build_web --wasm --no-tree-shake-icons
}

phase_build_web_canvaskit() {
  flutter config --enable-web
  # Drop the WASM output so the bundles never mix; no -f, since a missing build/web means the WASM build never ran.
  rm -r "${KATAGLYPHIS_REPO_ROOT}/build/web/"
  flutter_build_web --no-tree-shake-icons
}

SERVER_PID=""
stop_http_server() {
  # A server that already exited has failed the smoke test on its own.
  if [ -n "${SERVER_PID}" ] && kill -0 "${SERVER_PID}" 2>/dev/null; then
    kill "${SERVER_PID}"
  fi
}

phase_smoke_test() {
  local base_url="http://localhost:8080"
  cd "${KATAGLYPHIS_REPO_ROOT}/build/web"
  python3 -m http.server 8080 --bind 127.0.0.1 &
  SERVER_PID=$!
  trap stop_http_server EXIT
  cd "${KATAGLYPHIS_REPO_ROOT}"

  # wait_for_http returns rather than exits when the server never comes up.
  wait_for_http "${base_url}/" "http.server (pid ${SERVER_PID})" || exit 1

  bash "${KATAGLYPHIS_REPO_ROOT}/scripts/integration-smoke-test.sh" "${base_url}"
}

phase_dart_doc() {
  # rootUris into the repo's own .pub-cache make dartdoc die with "'_PhysicalFile' is not a subtype of type 'Folder'".
  export PUB_CACHE=/tmp/pub-cache
  rm -rf "${KATAGLYPHIS_REPO_ROOT}/.dart_tool"
  flutter pub get
  (cd "${KATAGLYPHIS_REPO_ROOT}/third_party/ANThology" && flutter pub get)
  dart doc
}

if [ "$#" -ne 1 ]; then
  echo "Error: exactly one phase argument required (got: $#)." >&2
  usage
  exit 2
fi

PHASE="$1"
container_prologue
case "${PHASE}" in
  dart-checks) phase_dart_checks ;;
  build-web-wasm) phase_build_web_wasm ;;
  smoke-test) phase_smoke_test ;;
  build-web-canvaskit) phase_build_web_canvaskit ;;
  dart-doc) phase_dart_doc ;;
  *)
    echo "Error: unknown phase: ${PHASE}" >&2
    usage
    exit 2
    ;;
esac
