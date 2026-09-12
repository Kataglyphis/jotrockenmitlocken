#!/usr/bin/env bash
# The containerised phases of .github/workflows/dart.yml - one phase per
# run-in-linux-container step, so a failing phase names itself in the runs UI.
#
# Usage: ci-container-steps.sh <phase>
#   dart-checks          scripts/run-dart-checks.sh (shared format/analyze/test gate)
#   build-web-wasm       flutter config --enable-web + WASM release build
#   smoke-test           serve build/web, run scripts/integration-smoke-test.sh
#   build-web-canvaskit  drop build/web, rebuild with CanvasKit (develop only)
#   dart-doc             dart doc into doc/api
#
# Every phase lands in a FRESH container: per-user state (PATH, git's
# safe.directory list, flutter's web flag, pub's default ~/.pub-cache) does not
# carry over between steps. The prologue re-establishes it, and the pub cache
# moves into the workspace so the packages dart-checks fetches are still where
# package_config.json says they are when the later phases resolve it.
#
# Env:
#   FLUTTER_DIR  Flutter SDK baked into the image (default: /opt/flutter)
#   PUB_CACHE    pub cache dir (default: <repo>/.pub-cache, gitignored)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# The submodule path and the not-found guard come from the canonical bootstrap
# (a verbatim copy of upstream's shared/linux/templates/antfrastructure.sh).
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/lib/antfrastructure.sh"

FLUTTER_DIR="${FLUTTER_DIR:-/opt/flutter}"

usage() {
  echo "Usage: $0 <dart-checks|build-web-wasm|smoke-test|build-web-canvaskit|dart-doc>" >&2
}

container_prologue() {
  # The image owns the Flutter SDK; nothing here installs one.
  if [ ! -x "${FLUTTER_DIR}/bin/flutter" ]; then
    echo "Error: no Flutter SDK at ${FLUTTER_DIR}." >&2
    echo "       The container image bakes it in; check FLUTTER_DIR and the image tag." >&2
    echo "       (Outside the container, point FLUTTER_DIR at your SDK.)" >&2
    exit 1
  fi
  export PATH="${FLUTTER_DIR}/bin:${PATH}"

  # The bind-mounted workspace and the SDK belong to another uid than the
  # container user; without safe.directory git refuses with "dubious
  # ownership", which kills the format gate's `git ls-files` and flutter itself.
  git config --global --add safe.directory "${KATAGLYPHIS_REPO_ROOT}"
  git config --global --add safe.directory "${FLUTTER_DIR}"

  export PUB_CACHE="${PUB_CACHE:-${KATAGLYPHIS_REPO_ROOT}/.pub-cache}"

  # The image is unpinned (latest-cross); say which Flutter this run got.
  flutter --version

  cd "${KATAGLYPHIS_REPO_ROOT}"
}

phase_dart_checks() {
  bash "${KATAGLYPHIS_REPO_ROOT}/scripts/run-dart-checks.sh"
}

phase_build_web_wasm() {
  # Per-user config, so per-container: enable web in the container that builds.
  flutter config --enable-web
  flutter build web --release --wasm --no-tree-shake-icons
}

phase_build_web_canvaskit() {
  flutter config --enable-web
  # develop deploys the WASM build first, then rebuilds with CanvasKit for the
  # dev domain; drop the WASM output so the two bundles never mix. `rm -r`
  # without -f: a missing build/web means the WASM build never ran - fail loud.
  rm -r "${KATAGLYPHIS_REPO_ROOT}/build/web/"
  flutter build web --release --no-tree-shake-icons
}

SERVER_PID=""
stop_http_server() {
  # kill -0 is a liveness probe: "already exited" is the one expected miss
  # (a crashed server has already failed the smoke test on its own).
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

  # Poll instead of the old `sleep 1`: probes failing while the server starts
  # are the expected case; a server that never comes up fails by name below.
  local ready=""
  for _ in $(seq 1 50); do
    if curl -fs -o /dev/null "${base_url}/"; then
      ready=1
      break
    fi
    sleep 0.2
  done
  if [ -z "${ready}" ]; then
    echo "Error: http.server (pid ${SERVER_PID}) never served ${base_url} within 10s." >&2
    exit 1
  fi

  bash "${KATAGLYPHIS_REPO_ROOT}/scripts/integration-smoke-test.sh" "${base_url}"
}

phase_dart_doc() {
  # dartdoc must NOT see a package resolution whose rootUris point INTO the
  # package being documented: with the warm workspace cache
  # (.pub-cache/ under the repo root) its embedder-SDK scan dies with
  # "type '_PhysicalFile' is not a subtype of type 'Folder'"
  # (package_builder.dart:126, Flutter 3.47.1). Measured 2026-09-07: the
  # physical cache directory is harmless, the in-tree rootUris are the trigger.
  # So this LAST phase re-resolves against a container-local cache (~30s) and
  # leaves the warm cache for the build phases untouched.
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
