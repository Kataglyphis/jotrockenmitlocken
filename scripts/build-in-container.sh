#!/usr/bin/env bash
# Build the Flutter web app inside the custom Kataglyphis container image,
# using the submodule at ExternalLib/Kataglyphis-ContainerHub to bootstrap
# Flutter (the image itself does not ship the Flutter SDK).
#
# Usage:
#   scripts/build-in-container.sh [--shell] [--canvaskit]
#
# Env vars:
#   IMAGE            Container image to build in (default: ghcr.io/kataglyphis/kataglyphis_beschleuniger:latest-cross)
#   FLUTTER_VERSION  Flutter SDK version to install inside the container (default: 3.44.0, matches CI)
#   ENGINE           Container engine to use: docker or nerdctl (default: docker)
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONTAINERHUB_DIR="${REPO_ROOT}/ExternalLib/Kataglyphis-ContainerHub"
CONTAINERHUB_SCRIPTS_DIR="${CONTAINERHUB_DIR}/linux/scripts"
# setup-flutter.sh sources a sibling ../../01-core/downloads.sh by relative
# path, so the whole scripts/ subtree must be mounted together, not just
# this one file.
SETUP_FLUTTER_SCRIPT_IN_CONTAINER="/opt/kataglyphis-scripts/05-frameworks/flutter/setup-flutter.sh"

IMAGE="${IMAGE:-ghcr.io/kataglyphis/kataglyphis_beschleuniger:latest-cross}"
FLUTTER_VERSION="${FLUTTER_VERSION:-3.44.0}"
ENGINE="${ENGINE:-docker}"

DROP_SHELL=false
BUILD_TARGET="wasm"
for arg in "$@"; do
  case "${arg}" in
    --shell) DROP_SHELL=true ;;
    --canvaskit) BUILD_TARGET="canvaskit" ;;
    *)
      echo "Unknown option: ${arg}" >&2
      echo "Usage: $0 [--shell] [--canvaskit]" >&2
      exit 1
      ;;
  esac
done

if [ ! -f "${CONTAINERHUB_SCRIPTS_DIR}/05-frameworks/flutter/setup-flutter.sh" ]; then
  echo "Error: ${CONTAINERHUB_SCRIPTS_DIR}/05-frameworks/flutter/setup-flutter.sh not found." >&2
  echo "Did you run 'git submodule update --init ExternalLib/Kataglyphis-ContainerHub'?" >&2
  exit 1
fi

BUILD_CMD='flutter config --enable-web && flutter pub get && (cd ExternalLib/jotrockenmitlockenrepo && flutter pub get)'
if [ "${BUILD_TARGET}" = "wasm" ]; then
  BUILD_CMD="${BUILD_CMD} && flutter build web --release --wasm --no-tree-shake-icons"
else
  BUILD_CMD="${BUILD_CMD} && flutter build web --release --no-tree-shake-icons"
fi

INSTALL_FLUTTER_CMD="bash ${SETUP_FLUTTER_SCRIPT_IN_CONTAINER} --arch x64 --version ${FLUTTER_VERSION} --dir /opt"

CONTAINER_CMD="
set -euo pipefail
${INSTALL_FLUTTER_CMD}
export PATH=\"/opt/flutter/bin:\${PATH}\"
flutter --version
cd /workspace
${BUILD_CMD}
"

if [ "${DROP_SHELL}" = "true" ]; then
  CONTAINER_CMD="${INSTALL_FLUTTER_CMD} && export PATH=\"/opt/flutter/bin:\${PATH}\" && cd /workspace && exec bash"
fi

exec "${ENGINE}" run --rm -it \
  --platform linux/amd64 \
  -v "${REPO_ROOT}:/workspace" \
  -v "${CONTAINERHUB_SCRIPTS_DIR}:/opt/kataglyphis-scripts:ro" \
  -w /workspace \
  "${IMAGE}" \
  bash -lc "${CONTAINER_CMD}"
