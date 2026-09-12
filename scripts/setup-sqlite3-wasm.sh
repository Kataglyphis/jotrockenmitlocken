#!/usr/bin/env bash
# Fetch the pinned sqlite3.wasm into web/, which is what a Flutter web build
# bundles and what the app needs to open its database in the browser.
#
#     bash scripts/setup-sqlite3-wasm.sh
#
# WHAT THIS FILE IS NOW. It used to be the fetch itself: a hardcoded
# VERSION="3.2.0" and a bare `curl -L --fail -o web/sqlite3.wasm` with no
# integrity check at all. jotrockenmitlocken and OmniAccelerANT carried
# byte-identical copies of it that differed on exactly that one line, so an
# unauthenticated third-party binary was being dropped into two shipped web
# bundles from two different pins. The fetch now lives upstream at
# third_party/ANTfrastructure/linux/scripts/05-frameworks/flutter/setup-sqlite3-wasm.sh,
# which resolves the version AND its SHA256 from ANTfrastructure's
# 01-core/versions.env and downloads through download_verified_file - so a
# tampered or truncated asset fails here instead of in a visitor's browser.
#
# TWO CONSEQUENCES OF ADOPTING IT, both wanted:
#   - the version moves 3.2.0 -> 3.3.1. That is a CORRECTION, not a drift:
#     pubspec.yaml has pinned `sqlite3: ^3.3.1` since the ANThology migration,
#     so this script had been fetching a wasm module older than the Dart
#     package that loads it.
#   - there is deliberately no version argument any more. A repo that needs
#     another build bumps SQLITE3_WASM_VERSION in ANTfrastructure's versions.env,
#     where the matching SHA256 lives; the two cannot drift apart there.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# The submodule path and the not-found guard come from the canonical bootstrap
# (a verbatim copy of upstream's shared/linux/templates/antfrastructure.sh).
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/lib/antfrastructure.sh"

if [ "$#" -gt 0 ]; then
  echo "Error: $0 takes no arguments (got: $*)." >&2
  echo "       The version is ANTfrastructure's SQLITE3_WASM_VERSION, pinned next to" >&2
  echo "       its SHA256 in linux/scripts/01-core/versions.env." >&2
  exit 2
fi

# The consumer root is passed EXPLICITLY. Upstream runs from inside
# third_party/ANTfrastructure, so a root it derived from its own location would
# write third_party/ANTfrastructure/web/sqlite3.wasm and the app would still not
# start - with a green log.
antfrastructure_exec linux/scripts/05-frameworks/flutter/setup-sqlite3-wasm.sh \
  "${KATAGLYPHIS_REPO_ROOT}"
