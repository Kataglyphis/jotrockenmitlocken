#!/usr/bin/env bash
# The repo's lint gate: shellcheck over this repo's bash, actionlint +
# ANTfrastructure's CI-image-ref check over its workflows, gitleaks over its
# tracked tree - all three using the pinned, SHA256-verified binaries
# ANTfrastructure bootstraps rather than a second set installed here.
#
# This is the single entry point .github/workflows/dart.yml calls, and the same
# one command to run before pushing:
#
#     bash scripts/run-lint-gates.sh
#
# WHAT THIS FILE IS NOW. It used to be 119 lines carrying the aggregation
# itself: the `git ls-files` scope construction, the empty-list vacuity guard,
# the run-all-three-then-fail-once accumulator, and two hand-rolled pin
# preconditions that grepped ANTfrastructure's own source text for a feature
# marker. All of that moved upstream to
# third_party/ANTfrastructure/linux/scripts/run-lint-gates.sh, which three other
# consumers now share; this file is the wrapper that keeps the local
# invocation. Everything below is that delegation plus the two decisions that
# are genuinely this repo's: the argument contract and the exclude set.
#
# The upstream aggregator does strictly MORE than the code it replaced:
#   - it reads `git ls-files -z`, so a path with non-ASCII bytes (this repo has
#     dummy_assets/) is not silently dropped by git's own quoting;
#   - it scans the top-level entries one at a time and keeps third_party/ out
#     of the secret gate, where the old single-root scan graded ANThology's and
#     ANTfrastructure's trees against THIS repo's .gitleaks.toml;
#   - it passes this repo's .gitleaks.toml explicitly, which per-path scanning
#     otherwise loses;
#   - it self-tests the secret gate before trusting it (plant a credential,
#     assert it is reported BY PATH and that the gate exits non-zero on it),
#     which is the guarantee the deleted grep-for-a-marker preconditions were
#     reaching for and could not express.
#
# Exit status: non-zero iff any of the three gates fails. All three still run
# even when an earlier one fails - one push should report every finding, not
# the first.
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

# The two failure modes are different problems with different fixes, so they get
# different messages. antfrastructure_path collapses them into one ("not found /
# it moved upstream"), which sends you to docs/INDEX.md for what is really a
# stale gitlink - and a stale gitlink is the expected failure while the fleet
# adopts this. This existence check REPLACES the two preconditions this file
# used to carry, and replaces them with something stronger: those grepped the
# pinned lint-secrets.sh for the literal 'SCAN_ROOT=' and the pinned
# lint-workflows.sh for 'verify_ci_image_refs', which breaks on any upstream
# rename and passes on any comment that happens to contain the string. The
# aggregator ships in the same ANTfrastructure commit as the three gates it runs,
# so its presence IS the capability - it cannot outrun them.
HUB_LINT_GATES_RELATIVE="linux/scripts/run-lint-gates.sh"
if [ ! -d "${ANTFRASTRUCTURE_DIR}" ]; then
  echo "Error: ANTfrastructure is not checked out at ${ANTFRASTRUCTURE_DIR}." >&2
  echo "       git submodule update --init --recursive third_party/ANTfrastructure" >&2
  exit 1
fi
if [ ! -f "${ANTFRASTRUCTURE_DIR}/${HUB_LINT_GATES_RELATIVE}" ]; then
  echo "Error: ${ANTFRASTRUCTURE_DIR}/${HUB_LINT_GATES_RELATIVE} is missing." >&2
  echo "       The pinned ANTfrastructure predates the shared lint aggregator, which" >&2
  echo "       also carries the consumer-scan-root support in lint-secrets.sh and" >&2
  echo "       the CI-image-ref check in lint-workflows.sh. An older pin would run" >&2
  echo "       the gates over ANTfrastructure's own tree and report GREEN over none of" >&2
  echo "       this repository's files." >&2
  echo "       Bump the third_party/ANTfrastructure gitlink." >&2
  exit 1
fi

# --exclude third_party, spelled out rather than left to the upstream default,
# because it is this repo's scope decision and it should be readable here: both
# submodules (ANThology, ANTfrastructure) are separate repositories, linted and
# secret-scanned in their own CI at their own ratchet. Upstream KEEPS the
# tracked plain files sitting directly inside an excluded directory - dropping
# the whole prefix would have hidden a file this repo owns.
#
# antfrastructure_exec, not `bash "$(antfrastructure_path ...)"`: exec makes the
# aggregator's exit status this script's, with no intermediate shell to lose it.
antfrastructure_exec "${HUB_LINT_GATES_RELATIVE}" \
  "${KATAGLYPHIS_REPO_ROOT}" \
  --exclude third_party
