#!/usr/bin/env bash
# Full integration test with Docker nginx.
# Requires: docker, curl
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
BUILD_DIR="$PROJECT_DIR/build/web"
CONTAINER_HUB_DIR="$PROJECT_DIR/ExternalLib/Kataglyphis-ContainerHub"
SHARED_NGINX_CONF="$CONTAINER_HUB_DIR/linux/webserver/templates/flutter-nginx-local.conf"

if [ ! -f "$BUILD_DIR/index.html" ]; then
  echo "Build not found. Building..."
  cd "$PROJECT_DIR" && flutter build web --release --wasm --no-tree-shake-icons
fi

if [ ! -f "$SHARED_NGINX_CONF" ]; then
  echo "Shared nginx config not found: $SHARED_NGINX_CONF"
  exit 1
fi

echo "=== Starting nginx ==="
CONTAINER=$(docker run -d --rm \
  -p 8080:8080 \
  -v "$BUILD_DIR:/usr/share/nginx/html:ro" \
  -v "$SHARED_NGINX_CONF:/etc/nginx/conf.d/default.conf:ro" \
  nginx:alpine 2>/dev/null) || {
    echo "Docker not available, falling back to Python HTTP server"
    cd "$BUILD_DIR" && python3 -m http.server 8080 --bind 0.0.0.0 &
    SERVER_PID=$!
    trap "kill $SERVER_PID 2>/dev/null" EXIT
}

echo "Waiting for server..."
for i in $(seq 1 10); do
  if curl -s -o /dev/null http://localhost:8080/ 2>/dev/null; then
    echo "Server ready"
    break
  fi
  sleep 1
done

echo ""
"$SCRIPT_DIR/integration-smoke-test.sh" http://localhost:8080
RESULT=$?

if [ -n "${CONTAINER:-}" ]; then
  docker stop "$CONTAINER" 2>/dev/null
fi

echo ""
if [ $RESULT -eq 0 ]; then
  echo "✓ Integration tests passed"
else
  echo "✗ Integration tests failed"
  exit $RESULT
fi
