#!/usr/bin/env bash
# Dependency upgrades for this repo, run through Renovate as a LOCAL CLI. Owner
# directive 2026-09-09: what this tool covers is upgraded with it, not by hand.
#
#     bash scripts/renovate-local.sh                     # what is behind
#     bash scripts/renovate-local.sh --apply --dry-run   # the plan, with pre-flight
#     bash scripts/renovate-local.sh --apply             # move the gitlinks
#
# WHY THIS REPO HAS A WRAPPER. The tool itself is ContainerHub's
# (linux/scripts/renovate-local.sh); this file exists only so the repo has the
# same one-command local entry point as its other scripts, and so the repo root
# is passed EXPLICITLY. Upstream defaults its target to $PWD, so running this
# from any subdirectory - or from third_party/ContainerHub itself - would grade
# the wrong tree and report a cheerful "up to date". The flags are yours; the root
# is not, which is why this forwards "$@" but supplies the root itself.
#
# WHAT IT ACTUALLY DOES HERE. The default manager is git-submodules, which is
# this repo's whole dependency surface for the tool: third_party/ANThology and
# third_party/ContainerHub, both of which declare `branch = main` in .gitmodules
# and are therefore both eligible for --apply. Dart packages are NOT covered -
# pubspec.yaml is pub's, and .github/dependabot.yml is still the live path for
# it. Nor is this a gate: no workflow runs it and it blocks no commit.
# .github/renovate.json is inert on GitHub - the Renovate App is installed on no
# repo in this family - and this script is the only thing that reads it.
#
# ON WINDOWS: run it from WSL. There is no node on the host, and the tool
# bootstraps a pinned, checksum-verified Node + Renovate into ~/.cache. The
# report half only reads, so it is safe from anywhere. --apply needs the git
# that WROTE the working tree: a Linux git over a Windows checkout sees every
# text file as CR-modified and would abort part way through, half applied.
# Upstream settles that itself - it switches to git.exe when WSL can reach the
# tree through it, and REFUSES up front, before moving anything, when it cannot.
#
# Rationale, the measurements behind all of the above, and the GitHub-token
# variant: third_party/ContainerHub/docs/dependency-updates.md
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# The submodule path and the not-found guard come from the canonical bootstrap
# (a verbatim copy of upstream's shared/linux/templates/containerhub.sh), so this
# script spells out neither.
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/lib/containerhub.sh"

# Named separately from containerhub_path's generic "not found / it moved
# upstream" message, for the same reason run-lint-gates.sh does it: while the
# fleet adopts this tool the expected failure is a stale gitlink, and being sent
# to docs/INDEX.md to look for a file that upstream has not yet been pinned at
# wastes the trip.
HUB_RENOVATE_RELATIVE="linux/scripts/renovate-local.sh"
if [ ! -f "${CONTAINERHUB_DIR}/${HUB_RENOVATE_RELATIVE}" ]; then
  echo "Error: ${CONTAINERHUB_DIR}/${HUB_RENOVATE_RELATIVE} is missing." >&2
  echo "       Either ContainerHub is not checked out (git submodule update" >&2
  echo "       --init --recursive third_party/ContainerHub), or the pinned" >&2
  echo "       ContainerHub predates the shared Renovate CLI - bump the" >&2
  echo "       third_party/ContainerHub gitlink." >&2
  exit 1
fi

# containerhub_exec, not `bash "$(containerhub_path ...)"`: exec makes the tool's
# exit status this script's, with no intermediate shell to lose it.
containerhub_exec "${HUB_RENOVATE_RELATIVE}" "${KATAGLYPHIS_REPO_ROOT}" "$@"
