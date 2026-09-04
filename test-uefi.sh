#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

ISO="live-image-amd64.hybrid.iso"
OVMF_CODE="/usr/share/OVMF/OVMF_CODE_4M.fd"
OVMF_VARS="/usr/share/OVMF/OVMF_VARS_4M.fd"

if [ ! -f "$ISO" ]; then
    echo "Error: $ISO not found."
    exit 1
fi

if [ ! -f "$OVMF_CODE" ] || [ ! -f "$OVMF_VARS" ]; then
    echo "Error: OVMF firmware files not found."
    exit 1
fi

# Give each VM run its own writable UEFI variable store.
VARS_COPY="$(mktemp --suffix=.fd)"
cp "$OVMF_VARS" "$VARS_COPY"
trap 'rm -f "$VARS_COPY"' EXIT

echo "Starting Fennec Linux in UEFI mode..."

qemu-system-x86_64 \
    -machine q35,accel=kvm \
    -m 2048 \
    -smp 2 \
    -drive if=pflash,format=raw,unit=0,readonly=on,file="$OVMF_CODE" \
    -drive if=pflash,format=raw,unit=1,file="$VARS_COPY" \
    -cdrom "$ISO" \
    -boot menu=on
