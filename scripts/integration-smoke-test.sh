#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# The submodule path and the not-found guard come from the synced bootstrap.
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/lib/antfrastructure.sh"

# Underscores, not hyphens: the kebab-case rename did not reach this upstream file.
SHARED_SCRIPT="$(antfrastructure_path linux/webserver/scripts/flutter_integration_smoke_test.sh)"

REQUIRED_CSP_HOSTS="www.gstatic.com fonts.gstatic.com" \
CHECK_LOADING_SHELL=1 \
  bash "$SHARED_SCRIPT" "$@"
