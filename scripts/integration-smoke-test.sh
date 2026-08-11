#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# The submodule path and the not-found guard come from the canonical bootstrap
# (a verbatim copy of upstream's shared/linux/templates/containerhub.sh), so this
# script spells out neither. containerhub_path also names the "it moved upstream"
# case, which the local guard did not.
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/lib/containerhub.sh"

# NOTE the underscores. This pointed at flutter_integration-smoke-test.sh
# (hyphens) and had been broken since the kebab-case script-renaming round; the
# local guard reported "not found" without saying the name had changed.
SHARED_SCRIPT="$(containerhub_path linux/webserver/scripts/flutter_integration_smoke_test.sh)"

REQUIRED_CSP_HOSTS="www.gstatic.com fonts.gstatic.com" \
CHECK_LOADING_SHELL=1 \
  bash "$SHARED_SCRIPT" "$@"
