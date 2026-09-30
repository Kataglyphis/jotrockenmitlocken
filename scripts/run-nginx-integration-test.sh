#!/usr/bin/env bash
# run-nginx-integration-test.sh - smoke test through the shared nginx config (headers, CSP, SPA rewrite); needs docker and curl.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# The submodule path and the not-found guard come from the synced bootstrap.
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/lib/antfrastructure.sh"

# wait_for_http returns rather than exits, so the container logs below still get printed.
antfrastructure_source linux/scripts/01-core/http-readiness.sh

PROJECT_DIR="$KATAGLYPHIS_REPO_ROOT"
BUILD_DIR="$PROJECT_DIR/build/web"

if [ ! -f "$BUILD_DIR/index.html" ]; then
  echo "Build not found. Building..."
  cd "$PROJECT_DIR" && flutter build web --release --wasm --no-tree-shake-icons
fi

# Resolved strictly: a missing file would otherwise serve nginx's default config and grade nothing.
SHARED_NGINX_CONF="$(antfrastructure_path linux/webserver/templates/flutter-nginx-local.conf)"

# --- teardown: trapped before the container exists, so any failure below still stops it ---
CONTAINER=""
stop_nginx() {
  if [ -n "$CONTAINER" ]; then
    # Not silenced: this message explains a container you later find still running.
    docker stop "$CONTAINER" >/dev/null || echo "Warning: could not stop container $CONTAINER" >&2
    CONTAINER=""
  fi
}
trap stop_nginx EXIT

echo "=== Starting nginx ==="
# No http.server fallback: it has none of the headers, CSP or rewrites under test, so it would pass vacuously.
if ! CONTAINER=$(docker run -d --rm \
  -p 8080:8080 \
  -v "$BUILD_DIR:/usr/share/nginx/html:ro" \
  -v "$SHARED_NGINX_CONF:/etc/nginx/conf.d/default.conf:ro" \
  nginx:alpine); then
  echo "Error: could not start the nginx container (docker error above)." >&2
  echo "       This script grades the shared nginx config, so there is no" >&2
  echo "       useful fallback. For a plain-static smoke test without docker:" >&2
  echo "       bash scripts/ci-container-steps.sh smoke-test" >&2
  exit 1
fi

# --- readiness: on a timeout the container's own logs hold the reason ---
BASE_URL="http://localhost:8080"
echo "Waiting for server..."
if ! wait_for_http "${BASE_URL}/" "nginx (container ${CONTAINER})"; then
  echo "       Container logs:" >&2
  # Unreadable logs are part of the diagnosis, so they are reported, not swallowed.
  if ! docker logs "$CONTAINER" >&2; then
    echo "       (could not read the container's logs either)" >&2
  fi
  exit 1
fi
echo "Server ready"

echo ""
# `|| RESULT=$?`: under set -e a bare call would abort before teardown; the status is re-raised below.
RESULT=0
"$SCRIPT_DIR/integration-smoke-test.sh" "$BASE_URL" || RESULT=$?

stop_nginx

echo ""
if [ "$RESULT" -eq 0 ]; then
  echo "✓ Integration tests passed"
else
  echo "✗ Integration tests failed"
  exit "$RESULT"
fi
