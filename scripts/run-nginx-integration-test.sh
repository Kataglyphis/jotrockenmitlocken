#!/usr/bin/env bash
# Serve build/web through the SHARED nginx config and run the smoke test
# against it - the one check in this repo that grades the webserver
# configuration (headers, CSP, SPA rewrite) rather than just the bundle.
#
#     bash scripts/run-nginx-integration-test.sh
#
# Requires: docker (or a compatible CLI), curl. Documented as a hand-run
# command in AGENTS.md; nothing in CI calls it.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# The submodule path and the not-found guard come from the canonical bootstrap
# (a verbatim copy of upstream's shared/linux/templates/antfrastructure.sh), so this
# script spells out neither. antfrastructure_path also names the "it moved upstream"
# case, which the local guard did not.
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/lib/antfrastructure.sh"

PROJECT_DIR="$KATAGLYPHIS_REPO_ROOT"
BUILD_DIR="$PROJECT_DIR/build/web"

if [ ! -f "$BUILD_DIR/index.html" ]; then
  echo "Build not found. Building..."
  cd "$PROJECT_DIR" && flutter build web --release --wasm --no-tree-shake-icons
fi

# ANTfrastructure owns the nginx config under test. Resolved through
# antfrastructure_path so a missing submodule fails by name instead of silently
# serving nginx's own default config and grading nothing this repo ships.
SHARED_NGINX_CONF="$(antfrastructure_path linux/webserver/templates/flutter-nginx-local.conf)"

# --- teardown ----------------------------------------------------------------
# One trap, set BEFORE the container exists, so an interrupt or a failure at any
# point below still stops it. The previous version stopped the container on a
# line AFTER the smoke test - which `set -e` never reached when the smoke test
# failed, leaking an nginx container on exactly the runs you re-run most.
CONTAINER=""
stop_nginx() {
  if [ -n "$CONTAINER" ]; then
    # Reported, not silenced: `docker stop 2>/dev/null` hid the one message
    # that explains a container you then find still running.
    docker stop "$CONTAINER" >/dev/null || echo "Warning: could not stop container $CONTAINER" >&2
    CONTAINER=""
  fi
}
trap stop_nginx EXIT

echo "=== Starting nginx ==="
# NO `2>/dev/null`, and NO fall back to `python3 -m http.server`. Both were
# here, and together they turned "docker is not available" into a green run of
# a DIFFERENT test: python's http.server serves the bundle with none of the
# headers, none of the CSP and none of the SPA rewrite rules that this script
# exists to grade, and the smoke test then printed "Integration tests passed".
# A pass that covered nothing is worse than a red. The plain-server smoke test
# still exists and is still one command away - it is the `smoke-test` phase of
# scripts/ci-container-steps.sh, which is also what CI runs.
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

# --- readiness ---------------------------------------------------------------
# Poll with an explicit `ready` flag and a hard failure. The old loop had
# neither: when the server never came up it simply fell out of the loop and ran
# the smoke test anyway, which then failed somewhere downstream with a message
# about the page instead of about the server. Same 10s budget, same shape as
# the poll in scripts/ci-container-steps.sh.
BASE_URL="http://localhost:8080"
echo "Waiting for server..."
READY=""
for _ in $(seq 1 50); do
  if curl -fs -o /dev/null "${BASE_URL}/"; then
    READY=1
    break
  fi
  sleep 0.2
done
if [ -z "$READY" ]; then
  echo "Error: nginx (container ${CONTAINER}) never served ${BASE_URL} within 10s." >&2
  echo "       Container logs:" >&2
  # Reported, never `|| true`: if the logs cannot be read that is itself part of
  # the diagnosis, and the exit status below is this script's regardless.
  if ! docker logs "$CONTAINER" >&2; then
    echo "       (could not read the container's logs either)" >&2
  fi
  exit 1
fi
echo "Server ready"

echo ""
# `|| RESULT=$?`, not a bare call followed by `RESULT=$?`. Under this file's own
# `set -euo pipefail` the bare form aborted the script on a failing smoke test,
# so RESULT was only ever assigned the value 0 and the "✗ Integration tests
# failed" branch below was unreachable code. Reproduced in isolation:
# `set -euo pipefail; false; RESULT=$?; echo reached` prints nothing, exit 1.
# This records the status so the teardown runs and the verdict is printed; it
# does not swallow it - the status is re-raised at the end.
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
