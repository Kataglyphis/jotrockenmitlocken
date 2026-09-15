#!/usr/bin/env bash
# The repo's lint gate - a thin wrapper over ANTfrastructure's shared aggregator.
# Which gates run, and why, is that script's header; the wrapper contract is in
# third_party/ANTfrastructure/docs/shared-script-libraries.md.
#
# This is the single entry point .github/workflows/dart.yml calls, and the same
# one command to run before pushing:
#
#     bash scripts/run-lint-gates.sh
#
# Exit status: non-zero iff any gate fails. All gates still run even when an
# earlier one fails - one push should report every finding, not the first.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# The submodule path and the not-found guard come from the canonical bootstrap
# (a verbatim copy of upstream's shared/linux/templates/antfrastructure.sh), so this
# script spells out neither.
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/lib/antfrastructure.sh"

# No pass-through: the one knob a caller might reach for is "skip a gate", and a
# gate that can be skipped from the command line is not a gate. The aggregator
# upstream does take --exclude; this repo's exclude set is a property of this
# repo, decided below, not of who is typing the command.
if [ "$#" -gt 0 ]; then
  echo "Error: $0 takes no arguments (got: $*)." >&2
  exit 2
fi

HUB_LINT_GATES_RELATIVE="linux/scripts/run-lint-gates.sh"

# --exclude third_party, spelled out rather than left to the upstream default,
# because it is this repo's scope decision and it should be readable here: both
# submodules (ANThology, ANTfrastructure) are separate repositories, linted and
# secret-scanned in their own CI at their own ratchet. Upstream KEEPS the
# tracked plain files sitting directly inside an excluded directory - dropping
# the whole prefix would have hidden a file this repo owns.
#
# --ratchets adds the eight measurement gates that take --root (code size,
# complexity, dead functions, comment size, stdout returns, masked declarations,
# trailing conditionals, the shellcheck warning ratchet) plus the doc-links gate
# over this tree, reading freeze files from the repo root. It is on because
# those freeze files are seeded and committed; upstream keeps the flag opt-in
# only because a tree with no freeze files is red on its first run, and that
# first report is what seeds them.
#
# antfrastructure_exec, not `bash "$(antfrastructure_path ...)"`: exec makes the
# aggregator's exit status this script's, with no intermediate shell to lose it.
antfrastructure_exec "${HUB_LINT_GATES_RELATIVE}" \
  "${KATAGLYPHIS_REPO_ROOT}" \
  --exclude third_party \
  --ratchets
