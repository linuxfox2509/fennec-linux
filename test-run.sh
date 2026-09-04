#!/bin/bash
set -e
ISO="live-image-amd64.hybrid.iso"
if [ ! -f "$ISO" ]; then
	echo "Error"
	exit 1
fi

echo "Starting QEMU with Fennec Linux..."

qemu-system-x86_64 -m 2048 -enable-kvm -cdrom "$ISO" -boot d
