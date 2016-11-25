#!/bin/sh
set -e
IMG_DIR="$HOME"
OS_BASE_IMAGE="$IMG_DIR/xenial-server-cloudimg-amd64-disk1.img"
OS_IMG="vm1-${OS_BASE_IMAGE##*/}"

qemu-img create -f qcow2 -o backing_file=$BASE_IMAGE "$OS_IMG"

exec qemu-system-x86_64 \
	-enable-kvm \
	-cpu host \
	-smp sockets=8,cores=1,threads=1 \
	-m 4096 \
	-machine pc-1.0,accel=kvm,usb=off \
	-rtc base=utc \
	-serial mon:stdio \
	-vga none -nographic \
	-netdev user,id=net0 \
	-device virtio-net,netdev=net0 \
	-netdev bridge,id=net1,br=cephbr \
	-device virtio-net,netdev=net1 \
	-drive format=qcow2,if=virtio,file="$OS_IMG" \
	-drive format=raw,if=virtio,file=vm1-config.iso,cache=none \
	${empty}

