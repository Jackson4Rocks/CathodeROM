#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
AOSP_DIR="$ROOT/aosp"
TOOLS_DIR="$ROOT/.tools"
REPO="$TOOLS_DIR/repo"
AOSP_TAG="android-16.0.0_r4"

# High-throughput defaults. Use 12 concurrent jobs by default.
# Override with:
#   CATHODEROM_SYNC_JOBS=24
#   CATHODEROM_NETWORK_JOBS=24
#   CATHODEROM_CHECKOUT_JOBS=24
SYNC_JOBS="${CATHODEROM_SYNC_JOBS:-24}"
NETWORK_JOBS="${CATHODEROM_NETWORK_JOBS:-24}"
CHECKOUT_JOBS="${CATHODEROM_CHECKOUT_JOBS:-24}"

if (( SYNC_JOBS < 1 || NETWORK_JOBS < 1 || CHECKOUT_JOBS < 1 )); then
  echo "error: concurrency values must be >= 1" >&2
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  echo "error: git is required" >&2
  exit 1
fi
if ! command -v curl >/dev/null 2>&1; then
  echo "error: curl is required" >&2
  exit 1
fi

mkdir -p "$TOOLS_DIR"

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

mkdir -p "$AOSP_DIR"
cd "$AOSP_DIR"

if [[ ! -d "$AOSP_DIR/.repo" ]]; then
  echo "Initializing AOSP $AOSP_TAG"
  "$REPO_CMD" init \
    -c \
    -u https://android.googlesource.com/platform/manifest \
    -b "$AOSP_TAG" \
    --use-superproject \
    --partial-clone \
    --clone-filter=blob:limit=10M
else
  echo "AOSP Repo checkout already initialized."
fi

mkdir -p "$AOSP_DIR/.repo/local_manifests"
cp "$ROOT/manifest/cathoderom.xml" "$AOSP_DIR/.repo/local_manifests/cathoderom.xml"

echo
echo "HIGH-THROUGHPUT SYNC"
echo "  Repo jobs       : $SYNC_JOBS"
echo "  Network jobs    : $NETWORK_JOBS"
echo "  Checkout jobs   : $CHECKOUT_JOBS"
echo "  Superproject    : enabled"
echo "  Partial clone   : enabled (10 MiB blob filter)"
echo "  Tags            : disabled"
echo

echo "Syncing AOSP and CathodeROM sources..."
"$REPO_CMD" sync \
  -c \
  -j"$SYNC_JOBS" \
  --jobs-network="$NETWORK_JOBS" \
  --jobs-checkout="$CHECKOUT_JOBS" \
  --no-interleaved \
  --optimized-fetch \

echo
echo "Bootstrap complete."
echo "Next:"
echo "  cd $AOSP_DIR"
echo "  source build/envsetup.sh"
echo "  lunch cathoderom_x86_64-userdebug"
echo "  m -j$(nproc)"
