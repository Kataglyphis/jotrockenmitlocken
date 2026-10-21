#!/usr/bin/env bash
# ci-container-steps.sh <phase> - one CI step per phase (dart-doc: build-docs.yml's build), each in a fresh container, so the prologue re-establishes state.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# The submodule path and the not-found guard come from the synced bootstrap.
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/lib/antfrastructure.sh"

antfrastructure_source linux/scripts/05-frameworks/flutter/lane-prologue.sh
antfrastructure_source linux/scripts/01-core/http-readiness.sh

usage() {
  echo "Usage: $0 <dart-checks|build-web-wasm|smoke-test|build-web-canvaskit|perf|dart-doc>" >&2
}

# The floor sits under the 76.1 % of lib/ measured on 2026-10-21 without the WebDAV content.
DART_COVERAGE_MIN=74

container_prologue() {
  # flutter_lane_prepare_env returns non-zero rather than exiting, so the exit is spelled here.
  flutter_lane_prepare_env "${FLUTTER_DIR:-/opt/flutter}" || exit 1
  cd "${KATAGLYPHIS_REPO_ROOT}"
}

phase_dart_checks() {
  bash "${KATAGLYPHIS_REPO_ROOT}/scripts/run-dart-checks.sh"
  bash "$(antfrastructure_path linux/scripts/05-frameworks/flutter/check-dart-coverage.sh)"     --min "${DART_COVERAGE_MIN}" --lcov "${KATAGLYPHIS_REPO_ROOT}/build/coverage/lcov.info"     --repo-root "${KATAGLYPHIS_REPO_ROOT}"
  # Again in the image's Chrome, where the site runs; the @TestOn('vm') files read the checkout and sit out.
  flutter test --platform chrome
  # The icons sit in web/app-icons/: Apache's default Alias /icons/ hides a site's own icons/.
  python3 "$(antfrastructure_path linux/scripts/05-frameworks/flutter/check-web-artefacts.py)"     --repo-root "${KATAGLYPHIS_REPO_ROOT}" --icons-dir app-icons
}

# The engine's emoji and symbol fonts, where web/flutter_bootstrap.js's fontFallbackBaseUrl points.
fetch_fallback_fonts() {
  python3 "$(antfrastructure_path linux/scripts/05-frameworks/flutter/fetch-fallback-fonts.py)"     --dest "${KATAGLYPHIS_REPO_ROOT}/build/web/fallback-fonts"
}

phase_build_web_wasm() {
  # Per-user config, so per-container: enable web in the container that builds.
  flutter config --enable-web
  # Every engine file from this site, none from Google's CDN (owner, 2026-10-21).
  flutter_build_web --wasm --no-web-resources-cdn --no-tree-shake-icons
  fetch_fallback_fonts
}

phase_build_web_canvaskit() {
  flutter config --enable-web
  # Drop the WASM output so the bundles never mix; no -f, since a missing build/web means the WASM build never ran.
  rm -r "${KATAGLYPHIS_REPO_ROOT}/build/web/"
  flutter_build_web --no-web-resources-cdn --no-tree-shake-icons
  fetch_fallback_fonts
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

# Frame timings in profile mode on the Linux desktop build, into out/perf/frontend.json for the frontend-perf-report action.
phase_perf() {
  xvfb-run -a flutter drive --profile -d linux     --driver=test_driver/perf_driver.dart --target=integration_test/performance_test.dart
}

phase_dart_doc() {
  # rootUris into the repo's own .pub-cache make dartdoc die with "'_PhysicalFile' is not a subtype of type 'Folder'".
  export PUB_CACHE=/tmp/pub-cache
  # dart doc writes over doc/api without clearing it, so a staged .htaccess or a deleted page would survive a rebuild.
  rm -rf "${KATAGLYPHIS_REPO_ROOT}/.dart_tool" "${KATAGLYPHIS_REPO_ROOT}/doc/api"
  flutter pub get
  (cd "${KATAGLYPHIS_REPO_ROOT}/third_party/ANThology" && flutter pub get)
  antfrastructure_source linux/scripts/lib/dartdoc-build.sh
  # The hub's builder: dartdoc set-up, plus the docs/ guides that builder cannot take.
  DARTDOC_BUILD_THEME_CSS="$(antfrastructure_path third_party/DocumANTation/style/dartdoc.css)"
  DARTDOC_BUILD_IMAGES_DIR="${KATAGLYPHIS_REPO_ROOT}/images"
  export DARTDOC_BUILD_THEME_CSS DARTDOC_BUILD_IMAGES_DIR
  # <source>|<slug>|<nav title>; the slug names guide-<slug>.html, so renaming one moves a URL.
  # shellcheck disable=SC2034 # read by dartdoc_build_stage_guides and dartdoc_build_render_guides
  DARTDOC_BUILD_GUIDES=(
    "${KATAGLYPHIS_REPO_ROOT}/docs/getting-started.md|getting-started|Getting started"
    "${KATAGLYPHIS_REPO_ROOT}/docs/publishing-posts.md|publishing-posts|Publishing posts"
  )
  dartdoc_build_main
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
  perf) phase_perf ;;
  dart-doc) phase_dart_doc ;;
  *)
    echo "Error: unknown phase: ${PHASE}" >&2
    usage
    exit 2
    ;;
esac
