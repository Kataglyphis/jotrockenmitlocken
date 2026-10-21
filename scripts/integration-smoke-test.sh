#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# The submodule path and the not-found guard come from the synced bootstrap.
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/lib/antfrastructure.sh"

# Underscores, not hyphens: the kebab-case rename did not reach this upstream file.
SHARED_SCRIPT="$(antfrastructure_path linux/webserver/scripts/flutter_integration_smoke_test.sh)"

# No CSP host to require: the build serves every engine and font file itself.
REQUIRED_CSP_HOSTS="" \
CHECK_LOADING_SHELL=1 \
CHECK_LOCAL_ENGINE=1 \
  bash "$SHARED_SCRIPT" "$@"
