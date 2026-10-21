#!/usr/bin/env bash
# run-dart-checks.sh - the Dart gate (pub get for root and ANThology, format on tracked files, analyze, test with coverage).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# The submodule path and the not-found guard come from the synced bootstrap.
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/lib/antfrastructure.sh"

# No arguments: --strict false would turn the blocking gate into a warning.
if [ "$#" -gt 0 ]; then
  echo "Error: $0 takes no arguments (got: $*)." >&2
  echo "       This is the blocking gate; it is fixed at --strict true." >&2
  echo "       For other knobs call ANTfrastructure's flutter_checks.sh directly." >&2
  exit 2
fi

# flutter_checks.sh works relative to the cwd.
cd "$KATAGLYPHIS_REPO_ROOT"

# ANThology needs its own pub get; the one VM test run writes the lcov ci-container-steps.sh's coverage floor reads.
antfrastructure_exec linux/scripts/05-frameworks/flutter/flutter_checks.sh \
  --strict true \
  --extra-package third_party/ANThology \
  --coverage build/coverage/lcov.info
