#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

echo "==> Purging previous Fennec build..."
sudo lb clean --purge

echo "==> Configuring release build..."
lb config \
  --distribution trixie \
  --architectures amd64 \
  --binary-images iso-hybrid \
  --archive-areas "main contrib non-free-firmware" \
  --bootappend-live "boot=live components username=fennec hostname=fennec" \
  --cache true \
  --cache-packages true \
  --checksums sha256

echo "==> Building Fennec Linux release..."
sudo lb build

echo
echo "Release build complete:"
echo "  live-image-amd64.hybrid.iso"
