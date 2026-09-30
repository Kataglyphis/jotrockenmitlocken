#!/usr/bin/env bash
# setup-sqlite3-wasm.sh - fetches the SHA256-verified sqlite3.wasm the web build bundles; the pin lives in the hub's versions.env.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# The submodule path and the not-found guard come from the synced bootstrap.
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/lib/antfrastructure.sh"

if [ "$#" -gt 0 ]; then
  echo "Error: $0 takes no arguments (got: $*)." >&2
  echo "       The version is ANTfrastructure's SQLITE3_WASM_VERSION, pinned next to" >&2
  echo "       its SHA256 in linux/scripts/01-core/versions.env." >&2
  exit 2
fi

# The root is explicit: one derived upstream would write into the submodule's web/, with a green log.
antfrastructure_exec linux/scripts/05-frameworks/flutter/setup-sqlite3-wasm.sh \
  "${KATAGLYPHIS_REPO_ROOT}"
