#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
AOSP_DIR="$ROOT/aosp"
TOOLS_DIR="$ROOT/.tools"
REPO="$TOOLS_DIR/repo"
AOSP_TAG="android-16.0.0_r4"

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

if [[ ! -d "$AOSP_DIR/.repo" ]]; then
  mkdir -p "$AOSP_DIR"
  echo "Initializing AOSP $AOSP_TAG"
  cd "$AOSP_DIR"
  "$REPO_CMD" init -u https://android.googlesource.com/platform/manifest -b "$AOSP_TAG"
else
  echo "AOSP Repo checkout already initialized."
fi

mkdir -p "$AOSP_DIR/.repo/local_manifests"
cp "$ROOT/manifest/cathoderom.xml" "$AOSP_DIR/.repo/local_manifests/cathoderom.xml"

cd "$AOSP_DIR"
echo "Syncing AOSP and CathodeROM sources..."
"$REPO_CMD" sync -c -j"$(nproc)" --no-clone-bundle --no-tags

echo
echo "Bootstrap complete."
echo "Next:"
echo "  cd $AOSP_DIR"
echo "  source build/envsetup.sh"
echo "  lunch cathoderom_x86_64-userdebug"
echo "  m -j\"\$(nproc)\""
