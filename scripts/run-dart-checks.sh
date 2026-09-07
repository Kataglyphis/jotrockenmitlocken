#!/usr/bin/env bash
# The repo's Dart gate: pub get (root + ANThology), format, analyze, test.
#
# CI used to inline those four commands in .github/workflows/dart.yml, which
# meant the gate drifted from every other Kataglyphis repo and its
# `dart format .` walked third_party/ANThology's 86 .dart files — a recursive
# walk cannot tell vendored code from ours. The shared driver enumerates
# tracked, non-vendored files instead.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# The submodule path and the not-found guard come from the canonical bootstrap
# (a verbatim copy of upstream's shared/linux/templates/containerhub.sh), so this
# script spells out neither. containerhub_path also names the "it moved upstream"
# case, which the local guard did not.
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/lib/containerhub.sh"

# No pass-through: silently dropping an argument would be worse, and the one
# knob a caller might reach for (--strict false) turns the gate into a warning.
if [ "$#" -gt 0 ]; then
  echo "Error: $0 takes no arguments (got: $*)." >&2
  echo "       This is the blocking gate; it is fixed at --strict true." >&2
  echo "       For other knobs call ContainerHub's flutter_checks.sh directly." >&2
  exit 2
fi

# flutter_checks.sh resolves dependencies and enumerates Dart files relative to
# the cwd, so run from the repo root whatever directory the caller was in.
cd "$KATAGLYPHIS_REPO_ROOT"

# --extra-package: ANThology is a submodule with its own pubspec, and the root
# package's `flutter test` does not resolve it without its own `flutter pub get`.
containerhub_exec linux/scripts/05-frameworks/flutter/flutter_checks.sh \
  --strict true \
  --extra-package third_party/ANThology
