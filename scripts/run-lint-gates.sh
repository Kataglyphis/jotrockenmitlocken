#!/usr/bin/env bash
# run-lint-gates.sh - the hub lint aggregator over this repo, with the same arguments web.yml's lint job passes.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# The submodule path and the not-found guard come from the synced bootstrap.
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/lib/antfrastructure.sh"

# No arguments: a gate that can be skipped from the command line is not a gate.
if [ "$#" -gt 0 ]; then
  echo "Error: $0 takes no arguments (got: $*)." >&2
  exit 2
fi

HUB_LINT_GATES_RELATIVE="linux/scripts/run-lint-gates.sh"

# Both submodules are graded in their own repos; the freeze files for --ratchets are committed.
antfrastructure_exec "${HUB_LINT_GATES_RELATIVE}" \
  "${KATAGLYPHIS_REPO_ROOT}" \
  --exclude third_party \
  --ratchets
