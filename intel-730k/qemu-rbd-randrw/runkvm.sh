#!/bin/sh
set -e
MYDIR="${0%/*}"
SHARED_DIR="`readlink -f ${MYDIR}/../..`"
scripts_dir="`readlink -f ${MYDIR}/../../scripts`"

IMG_DIR="/srv/data/Public/img/xenial/20161214"
OS_BASE_IMAGE="$IMG_DIR/xenial-server-cloudimg-amd64-disk1.img"
OS_IMG="qemu-rbd-guest-${OS_BASE_IMAGE##*/}"
CONFIGDRIVE="configdrive-${OS_BASE_IMAGE##*/}.iso"
IMAGE="rbd/`hostname`-fio-vol00.img"
IMG_SIZE=120 # GB

qemu-img create -f qcow2 -o backing_file=$OS_BASE_IMAGE "$OS_IMG"

# transparent hugepages and merging same pages cause major IOPS jitter
sudo /bin/sh -c 'echo madvise > /sys/kernel/mm/transparent_hugepage/enabled'
sudo /bin/sh -c 'echo 0 > /sys/kernel/mm/ksm/run'
cpu_count=`nproc`
for i in `seq 0 $((cpu_count-1))`; do
	sudo /bin/sh -c "echo performance > /sys/devices/system/cpu/cpu${i}/cpufreq/scaling_governor"
done

if ! rbd info "$IMAGE" >/dev/null 2>&1; then
	rbd create \
		--image-format 2 \
		--image-feature layering \
		--size ${IMG_SIZE}G \
		"$IMAGE"
	"${scripts_dir}/fill_rbd_image.py" "${IMAGE}"
fi

if [ ! -f "$CONFIGDRIVE" ]; then
	"${scripts_dir}/mkconfigdrive.sh" "$CONFIGDRIVE"
fi

exec qemu-system-x86_64 \
	-enable-kvm \
	-cpu host \
	-smp sockets=2,cores=1,threads=1 \
	-m 4096 \
	-machine pc-1.0,accel=kvm,usb=off \
	-rtc base=utc \
	-serial mon:stdio \
	-vga none -nographic \
	-netdev user,id=net0 \
	-device virtio-net,netdev=net0 \
	-netdev bridge,id=net1,br=brceph \
	-device virtio-net,netdev=net1 \
	-drive format=qcow2,if=virtio,file="$OS_IMG" \
	-drive format=raw,if=virtio,file=${CONFIGDRIVE},cache=none \
	-drive format=raw,if=virtio,file=rbd:${IMAGE}:rbd_cache=true,cache=writeback \
        -fsdev local,id=work,path=${SHARED_DIR},security_model=none \
        -device virtio-9p-pci,fsdev=work,mount_tag=work \
	${empty}

