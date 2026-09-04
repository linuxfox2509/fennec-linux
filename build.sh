#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

echo "==> Cleaning previous Fennec build..."
sudo lb clean

echo "==> Configuring development build..."
lb config \
  --distribution trixie \
  --architectures amd64 \
  --binary-images iso-hybrid \
  --archive-areas "main contrib non-free-firmware" \
  --bootappend-live "boot=live components username=fennec hostname=fennec" \
  --cache true \
  --cache-packages true \
  --checksums none

echo "==> Building Fennec Linux..."
sudo lb build

echo
echo "Build complete:"
echo "  live-image-amd64.hybrid.iso"
