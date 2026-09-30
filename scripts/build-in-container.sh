#!/usr/bin/env bash
# build-in-container.sh [--canvaskit] - web build in the CI image with FLUTTER_VERSION instead of the image's own; ENGINE picks the engine.
set -euo pipefail

# KATAGLYPHIS_REPO_ROOT and ANTFRASTRUCTURE_DIR come from the synced bootstrap.
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

# No extra mount: the submodule sits inside /workspace with the whole subtree setup-flutter.sh sources.
SETUP_FLUTTER_IN_CONTAINER="/workspace/third_party/ANTfrastructure/linux/scripts/05-frameworks/flutter/setup-flutter.sh"

# Checked on the host: in the container the same miss surfaces a screen of pull output later.
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
# Only when asked: unset, the driver picks nerdctl if installed, else docker.
if [ -n "${ENGINE:-}" ]; then
  DRIVER_ARGS+=(--engine "${ENGINE}")
fi

exec bash "${RUN_IN_CI_IMAGE}" "${REPO_ROOT}" "${DRIVER_ARGS[@]}" -- bash -lc "${CONTAINER_CMD}"
