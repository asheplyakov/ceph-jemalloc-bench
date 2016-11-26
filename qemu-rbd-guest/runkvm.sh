#!/bin/sh
set -e
IMG_DIR="$HOME"
OS_BASE_IMAGE="$IMG_DIR/xenial-server-cloudimg-amd64-disk1.img"
OS_IMG="vm1-${OS_BASE_IMAGE##*/}"
TEST_IMG="rbd/vm1-vol00.img.raw"
TEST_IMG_SIZE=512 # GB

qemu-img create -f qcow2 -o backing_file=$OS_BASE_IMAGE "$OS_IMG"
if rbd info "$TEST_IMG" >/dev/null 2>&1; then
	rbd rm "$TEST_IMG"
fi
rbd create \
	--image-format 2 \
	--image-feature layering \
	--size ${TEST_IMG_SIZE}G \
	"$TEST_IMG"

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
	-drive format=raw,if=virtio,file=rbd:${TEST_IMG}:rbd_cache=true,cache=writeback \
        -fsdev local,id=work,path=/home/asheplyakov/jemalloc-bench,security_model=none \
        -device virtio-9p-pci,fsdev=work,mount_tag=work \
	${empty}

