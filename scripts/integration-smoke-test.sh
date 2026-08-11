#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONTAINER_HUB_DIR="${SCRIPT_DIR}/../ExternalLib/Kataglyphis-ContainerHub"
SHARED_SCRIPT="${CONTAINER_HUB_DIR}/linux/webserver/scripts/flutter_integration-smoke-test.sh"

if [ ! -f "$SHARED_SCRIPT" ]; then
  echo "Shared integration smoke test not found: $SHARED_SCRIPT"
  exit 1
fi

REQUIRED_CSP_HOSTS="www.gstatic.com fonts.gstatic.com" \
CHECK_LOADING_SHELL=1 \
  bash "$SHARED_SCRIPT" "$@"
