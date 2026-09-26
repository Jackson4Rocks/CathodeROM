#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
AOSP_DIR="$ROOT/aosp"
TOOLS_DIR="$ROOT/.tools"
REPO="$TOOLS_DIR/repo"
AOSP_TAG="android-16.0.0_r4"

# Keep sync responsive on normal desktops/laptops. Override any of these
# variables for a faster machine:
#   CATHODEROM_SYNC_JOBS=12
#   CATHODEROM_NETWORK_JOBS=6
#   CATHODEROM_CHECKOUT_JOBS=6
CPU_COUNT="$(nproc --all)"
SYNC_JOBS="${CATHODEROM_SYNC_JOBS:-$(( CPU_COUNT < 8 ? CPU_COUNT : 8 ))}"
NETWORK_JOBS="${CATHODEROM_NETWORK_JOBS:-4}"
CHECKOUT_JOBS="${CATHODEROM_CHECKOUT_JOBS:-4}"

if (( SYNC_JOBS < 1 )); then SYNC_JOBS=1; fi
if (( NETWORK_JOBS < 1 )); then NETWORK_JOBS=1; fi
if (( CHECKOUT_JOBS < 1 )); then CHECKOUT_JOBS=1; fi

if ! command -v git >/dev/null 2>&1; then
  echo "error: git is required" >&2
  exit 1
fi
if ! command -v curl >/dev/null 2>&1; then
  echo "error: curl is required" >&2
  exit 1
fi
if ! command -v nproc >/dev/null 2>&1; then
  echo "error: nproc is required (usually provided by coreutils)" >&2
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
echo "Sync configuration:"
echo "  CPU threads available : $CPU_COUNT"
echo "  Repo jobs             : $SYNC_JOBS"
echo "  Network jobs          : $NETWORK_JOBS"
echo "  Checkout jobs         : $CHECKOUT_JOBS"
echo "  Superproject          : enabled"
echo "  Partial clone         : enabled (10 MiB blob filter)"
echo "  Tags                  : disabled"
echo

echo "Syncing AOSP and CathodeROM sources..."
SYNC_CMD=(
  "$REPO_CMD" sync
  -c
  -j"$SYNC_JOBS"
  --jobs-network="$NETWORK_JOBS"
  --jobs-checkout="$CHECKOUT_JOBS"
  --no-interleaved
  --optimized-fetch
  --no-tags
)

# Lower CPU/IO scheduling priority when util-linux provides ionice/nice.
# This keeps the desktop responsive while the source tree is downloading.
if command -v ionice >/dev/null 2>&1 && command -v nice >/dev/null 2>&1; then
  ionice -c 3 nice -n 10 "${SYNC_CMD[@]}"
else
  "${SYNC_CMD[@]}"
fi

echo
echo "Bootstrap complete."
echo "Next:"
echo "  cd $AOSP_DIR"
echo "  source build/envsetup.sh"
echo "  lunch cathoderom_x86_64-userdebug"
echo "  m -j\$(nproc)"
echo
echo "For a faster machine, set CATHODEROM_SYNC_JOBS/CATHODEROM_NETWORK_JOBS/"
echo "CATHODEROM_CHECKOUT_JOBS before running this script."
