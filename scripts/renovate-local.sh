#!/usr/bin/env bash
# renovate-local.sh - Renovate as a local CLI over the root it passes explicitly; run from WSL; see third_party/ANTfrastructure/docs/dependency-updates.md.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# The submodule path comes from the synced bootstrap.
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/lib/antfrastructure.sh"

# The copied bootstrap initializes the hub only for a real apply.
antfrastructure_renovate_exec linux/scripts/renovate-local.sh "$KATAGLYPHIS_REPO_ROOT" "$@"
