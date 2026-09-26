#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
AOSP_DIR="$ROOT/aosp"
BUILD_JOBS="${CATHODEROM_BUILD_JOBS:-24}"

if ! [[ "$BUILD_JOBS" =~ ^[1-9][0-9]*$ ]]; then
  echo "error: CATHODEROM_BUILD_JOBS must be a positive integer" >&2
  exit 1
fi

if [[ ! -d "$AOSP_DIR" ]]; then
  echo "error: AOSP checkout not found at $AOSP_DIR" >&2
  echo "Run ./tools/bootstrap.sh first." >&2
  exit 1
fi

cd "$AOSP_DIR"
source build/envsetup.sh
lunch cathoderom_x86_64-userdebug

echo
echo "CathodeROM build"
echo "  Ninja jobs: $BUILD_JOBS"
echo

m -j"$BUILD_JOBS"
