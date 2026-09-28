#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="$ROOT/lineage"
TOOLS_DIR="$ROOT/.tools"
REPO="$TOOLS_DIR/repo"
TMP_DIR="$ROOT/.tmp"
export TMPDIR="$TMP_DIR"

SYNC_JOBS="${CATHODEROM_SYNC_JOBS:-12}"
NETWORK_JOBS="${CATHODEROM_NETWORK_JOBS:-2}"
CHECKOUT_JOBS="${CATHODEROM_CHECKOUT_JOBS:-8}"
BRANCH="lineage-23.2"

mkdir -p "$TOOLS_DIR" "$TMP_DIR"

if command -v repo >/dev/null 2>&1; then
  REPO_CMD="$(command -v repo)"
else
  REPO_CMD="$REPO"
  if [[ ! -x "$REPO_CMD" ]]; then
    echo "Installing the Repo launcher into $REPO_CMD"
    curl -fL https://storage.googleapis.com/git-repo-downloads/repo -o "$REPO_CMD"
    chmod 0755 "$REPO_CMD"
  fi
fi

mkdir -p "$SOURCE_DIR"
cd "$SOURCE_DIR"

if [[ ! -d "$SOURCE_DIR/.repo/repo" ]]; then
  echo "Initializing LineageOS $BRANCH"
  "$REPO_CMD" init     -u https://github.com/LineageOS/android.git     -b "$BRANCH"     --git-lfs
else
  echo "LineageOS Repo checkout already initialized."
fi

mkdir -p "$SOURCE_DIR/.repo/local_manifests"
cp "$ROOT/manifest/cathoderom-lineage.xml"    "$SOURCE_DIR/.repo/local_manifests/cathoderom-lineage.xml"

echo
echo "CATHODEOS LINEAGE PC SYNC"
echo "  Branch          : $BRANCH"
echo "  Repo jobs       : $SYNC_JOBS"
echo "  Network jobs    : $NETWORK_JOBS"
echo "  Checkout jobs   : $CHECKOUT_JOBS"
echo

"$REPO_CMD" sync   -c   -j"$SYNC_JOBS"   --jobs-network="$NETWORK_JOBS"   --jobs-checkout="$CHECKOUT_JOBS"   --no-interleaved   --optimized-fetch

echo
echo "LineageOS PC source sync complete."
echo
echo "Next:"
echo "  cd $SOURCE_DIR"
echo "  source build/envsetup.sh"
echo "  lunch cathoderom_pc_x86_64-userdebug"
echo "  TMPDIR="$SOURCE_DIR/.tmp" m -j1"
