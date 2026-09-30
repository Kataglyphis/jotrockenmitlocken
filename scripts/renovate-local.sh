#!/usr/bin/env bash
# renovate-local.sh - Renovate as a local CLI over the root it passes explicitly; run from WSL; see third_party/ANTfrastructure/docs/dependency-updates.md.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# The submodule path and the not-found guard come from the synced bootstrap.
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/lib/antfrastructure.sh"

# Own guard: the likely failure is a gitlink pinned before the driver existed, not a moved file.
HUB_RENOVATE_RELATIVE="linux/scripts/renovate-local.sh"
if [ ! -f "${ANTFRASTRUCTURE_DIR}/${HUB_RENOVATE_RELATIVE}" ]; then
  echo "Error: ${ANTFRASTRUCTURE_DIR}/${HUB_RENOVATE_RELATIVE} is missing." >&2
  echo "       Either ANTfrastructure is not checked out (git submodule update" >&2
  echo "       --init --recursive third_party/ANTfrastructure), or the pinned" >&2
  echo "       ANTfrastructure predates the shared Renovate CLI - bump the" >&2
  echo "       third_party/ANTfrastructure gitlink." >&2
  exit 1
fi

# exec keeps the tool's exit status.
antfrastructure_exec "${HUB_RENOVATE_RELATIVE}" "${KATAGLYPHIS_REPO_ROOT}" "$@"
