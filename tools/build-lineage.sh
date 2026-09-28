#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="$ROOT/lineage"
BUILD_JOBS="${CATHODEROM_BUILD_JOBS:-1}"

if ! [[ "$BUILD_JOBS" =~ ^[1-9][0-9]*$ ]]; then
  echo "error: CATHODEROM_BUILD_JOBS must be a positive integer" >&2
  exit 1
fi

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "error: LineageOS checkout not found at $SOURCE_DIR" >&2
  echo "Run ./tools/bootstrap-lineage.sh first." >&2
  exit 1
fi

cd "$SOURCE_DIR"
source build/envsetup.sh
lunch cathoderom_pc_x86_64-userdebug

echo
echo "CathodeOS Lineage PC build"
echo "  Ninja jobs: $BUILD_JOBS"
echo

TMPDIR="$SOURCE_DIR/.tmp" m -j"$BUILD_JOBS"
