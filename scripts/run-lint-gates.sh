#!/usr/bin/env bash
# The repo's lint gate: shellcheck over this repo's bash, actionlint +
# ContainerHub's CI-image-ref check over its workflows, gitleaks over its
# working tree - all three using the pinned, SHA256-verified binaries
# ContainerHub bootstraps rather than a second set installed here.
#
# This is the single entry point .github/workflows/dart.yml calls, and the same
# one command to run before pushing:
#
#     bash scripts/run-lint-gates.sh
#
# It used to live only as three `run:` blocks in dart.yml - file-list
# construction, vacuity guard and pin precondition all in YAML - so the gate
# that blocks the deploy could not be reproduced locally at all. Everything
# below is that YAML, unchanged in behaviour.
#
# Exit status: non-zero iff any of the three gates fails. All three run even
# when an earlier one fails (one push should report every finding, not the
# first), and the failure is remembered in FAILED and re-raised at the end -
# `|| FAILED=1` records a failure here, it does not swallow one.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# The submodule path and the not-found guard come from the canonical bootstrap
# (a verbatim copy of upstream's shared/linux/templates/containerhub.sh), so this
# script spells out neither. containerhub_path also names the "it moved upstream"
# case, which a local -f test would not.
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/lib/containerhub.sh"

# No pass-through: the one knob a caller might reach for is "skip a gate", and a
# gate that can be skipped from the command line is not a gate.
if [ "$#" -gt 0 ]; then
  echo "Error: $0 takes no arguments (got: $*)." >&2
  exit 2
fi

# git ls-files and the gitleaks/actionlint scan roots are all relative to the
# superproject root, whatever directory the caller was in.
cd "$KATAGLYPHIS_REPO_ROOT"

FAILED=0

# --- shellcheck --------------------------------------------------------------
# The file list comes from `git ls-files`, NOT from a glob. A bare
# `scripts/**/*.sh` does not recurse without `shopt -s globstar`, so it would
# have covered scripts/*.sh and silently skipped scripts/lib/ - and a lint gate
# that checks four of seven files still reports green. third_party/ is dropped
# because vendored trees are linted in their own repos, at their own ratchet.
# The count is asserted rather than assumed: an empty list is the exact failure
# mode this construction exists to prevent, so it fails instead of passing over
# nothing.
echo "== shellcheck (ContainerHub gate) =="
mapfile -t sh_files < <(git ls-files '*.sh' | grep -v '^third_party/')
if [ "${#sh_files[@]}" -eq 0 ]; then
  echo "Error: no first-party shell scripts matched; the gate would have checked nothing." >&2
  exit 1
fi
printf 'linting %d shell script(s):\n' "${#sh_files[@]}"
printf '  %s\n' "${sh_files[@]}"
# Resolved into a variable first: `bash "$(containerhub_path ...)" ... || FAILED=1`
# would turn "submodule not checked out" into an ordinary gate failure, because
# the `||` swallows the substitution's exit status. As an assignment it aborts.
hub_shell_lint="$(containerhub_path linux/scripts/lint-shell.sh)"
bash "$hub_shell_lint" "${sh_files[@]}" || FAILED=1

# --- actionlint + CI image refs ----------------------------------------------
# The root argument is mandatory for a consumer: the script lives inside the
# submodule, so its default root resolves to ContainerHub and the gate would
# lint the wrong tree while still reporting green.
# .github/actionlint.yaml teaches the pinned actionlint (1.7.12) about the
# ubuntu-26.04 runner label, which it predates.
#
# The precondition is checked rather than assumed, for the same reason the
# gitleaks one below is. Since the fleet moved the two CI image tags into
# ContainerHub's versions.env, lint-workflows.sh also runs
# verify_ci_image_refs.py - which is what keeps dart.yml's container steps on
# :latest-cross now that they OMIT `image:` and inherit the action default. A
# ContainerHub pin from before that change runs actionlint only: it exits 0, and
# the image convention this repo now depends on is graded by nothing.
echo "== actionlint + CI image refs (ContainerHub gate) =="
hub_workflow_lint="$(containerhub_path linux/scripts/lint-workflows.sh)"
if ! grep -q 'verify_ci_image_refs' "$hub_workflow_lint"; then
  echo "Error: ${hub_workflow_lint} predates the CI-image-ref check;" >&2
  echo "       it would lint workflows only and leave the :latest-cross /" >&2
  echo "       :winamd64 convention ungraded. Bump the third_party/ContainerHub" >&2
  echo "       gitlink to a commit that has linux/scripts/verify_ci_image_refs.py." >&2
  exit 1
fi
bash "$hub_workflow_lint" "$KATAGLYPHIS_REPO_ROOT" || FAILED=1

# --- gitleaks ----------------------------------------------------------------
# This repository holds FTP and WebDAV deploy credentials - as `${{ secrets.* }}`
# references, which is the point: the gate is what keeps it that way. The scan
# root must be ABSOLUTE (the script cd's to the ContainerHub checkout first, so a
# relative "." would grade the submodule), and the scanned tree's own
# .gitleaks.toml is what grades it.
#
# The precondition is checked rather than assumed. A ContainerHub pin from before
# the consumer-scan-root change IGNORES the argument and scans ContainerHub
# instead - it exits 0, and the gate reports green having looked at none of this
# repository's files. A vacuously green secret gate is worse than none, so this
# fails loudly and names the fix.
echo "== gitleaks (ContainerHub gate) =="
hub_secret_lint="$(containerhub_path linux/scripts/lint-secrets.sh)"
if ! grep -q 'SCAN_ROOT=' "$hub_secret_lint"; then
  echo "Error: ${hub_secret_lint} predates the consumer scan-root support;" >&2
  echo "       it would scan ContainerHub and report green. Bump the" >&2
  echo "       third_party/ContainerHub gitlink to a commit that has it." >&2
  exit 1
fi
bash "$hub_secret_lint" "$KATAGLYPHIS_REPO_ROOT" || FAILED=1

if [ "$FAILED" -ne 0 ]; then
  echo "LINT GATES FAILED" >&2
  exit 1
fi
echo "LINT GATES OK"
