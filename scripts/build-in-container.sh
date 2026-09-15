#!/usr/bin/env bash
# Build the Flutter web app inside the family Linux CI image with a
# CALLER-CHOSEN Flutter version. The image DOES ship its own SDK at
# /opt/flutter (since the lanes moved onto latest-cross, 2026-09-07) - this
# script stays useful exactly when you want a version OTHER than the image's
# pin; to build with the image's own Flutter, use the CI path
# (scripts/ci-container-steps.sh) instead.
#
# Usage:
#   scripts/build-in-container.sh [--canvaskit]
#
# Env vars:
#   FLUTTER_VERSION  Flutter SDK version to bootstrap inside the container
#                    (default: 3.44.0; CI no longer pins one - it uses the
#                    image's SDK)
#   ENGINE           Container engine: docker or nerdctl. Unset lets the driver
#                    choose (nerdctl if present, else docker).
#
# THE CONTAINER INVOCATION IS NOT THIS REPO'S. It used to be a hand-typed
# `${ENGINE} run --rm -it --platform ... -v ... -w ...` line here, one of a
# family of such lines that had each drifted - a different tag, a forgotten
# MSYS_NO_PATHCONV, a bind mount at another path, a missing safe.directory.
# ANTfrastructure ships that line once as linux/scripts/run-in-ci-image.sh
# (third_party/ANTfrastructure/docs/shared-script-libraries.md
# #run-in-ci-imagesh--run-a-command-in-the-ci-image),
# and this script now hands it a command.
#
# TWO KNOBS WENT WITH THE RECIPE, and neither is worth keeping a second recipe
# alive for:
#   * --shell. The driver deliberately exposes no interactive passthrough (no
#     -it), and an interactive shell was only ever a way to poke around a
#     container this script had already composed. Run the phases, or type your
#     own `nerdctl run -it` for a one-off.
#   * IMAGE. The driver resolves the reference through the same
#     linux/scripts/ci-image-ref.sh this script used to call, out of the hub's
#     linux/scripts/01-core/versions.env, which is the fleet's one owner of it.
#     Nothing in this repo ever set IMAGE to anything else.
set -euo pipefail

# REPO_ROOT and ANTFRASTRUCTURE_DIR come from the canonical bootstrap - a verbatim
# copy of upstream's shared/linux/templates/antfrastructure.sh - rather than being
# spelled out here. Six repos each had their own version of these two lines and
# they had drifted; see ANTfrastructure shared/linux/templates/README.md.
# shellcheck source=/dev/null
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/antfrastructure.sh"

REPO_ROOT="${KATAGLYPHIS_REPO_ROOT}"
FLUTTER_VERSION="${FLUTTER_VERSION:-3.44.0}"

BUILD_TARGET="wasm"
for arg in "$@"; do
  case "${arg}" in
    --canvaskit) BUILD_TARGET="canvaskit" ;;
    *)
      echo "Unknown option: ${arg}" >&2
      echo "Usage: $0 [--canvaskit]" >&2
      exit 1
      ;;
  esac
done

# No separate -v for the hub scripts. The repo root is bind-mounted at
# /workspace and ANTfrastructure is a submodule INSIDE it, so setup-flutter.sh -
# which sources a sibling ../../01-core/downloads.sh by relative path and
# therefore needs its whole subtree, not just the one file - is already there.
# The old second mount at /opt/kataglyphis-scripts existed only because the
# hand-typed recipe could mount whatever it liked.
SETUP_FLUTTER_IN_CONTAINER="/workspace/third_party/ANTfrastructure/linux/scripts/05-frameworks/flutter/setup-flutter.sh"

# Checked HERE, on the host, against the real path: inside the container the
# same miss is a bash "No such file or directory" a screen of pull output later.
antfrastructure_path linux/scripts/05-frameworks/flutter/setup-flutter.sh >/dev/null

BUILD_CMD='flutter config --enable-web && flutter pub get && (cd third_party/ANThology && flutter pub get)'
if [ "${BUILD_TARGET}" = "wasm" ]; then
  BUILD_CMD="${BUILD_CMD} && flutter build web --release --wasm --no-tree-shake-icons"
else
  BUILD_CMD="${BUILD_CMD} && flutter build web --release --no-tree-shake-icons"
fi

CONTAINER_CMD="
set -euo pipefail
bash ${SETUP_FLUTTER_IN_CONTAINER} --arch x64 --version ${FLUTTER_VERSION} --dir /opt
export PATH=\"/opt/flutter/bin:\${PATH}\"
flutter --version
cd /workspace
${BUILD_CMD}
"

RUN_IN_CI_IMAGE="$(antfrastructure_path linux/scripts/run-in-ci-image.sh)"

DRIVER_ARGS=(--platform linux/amd64)
# Passed only when the caller asked for one: unset, the driver picks nerdctl if
# it is installed and docker otherwise, which is the right answer on both the
# Rancher Desktop dev box and a docker CI host.
if [ -n "${ENGINE:-}" ]; then
  DRIVER_ARGS+=(--engine "${ENGINE}")
fi

exec bash "${RUN_IN_CI_IMAGE}" "${REPO_ROOT}" "${DRIVER_ARGS[@]}" -- bash -lc "${CONTAINER_CMD}"
