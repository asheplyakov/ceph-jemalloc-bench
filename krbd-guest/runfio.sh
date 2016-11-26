#!/bin/sh
set -e
IMAGE="rbd/`hostname`-fio-krbd-vol00.img"
IMG_SIZE=512 # GB
DURATION=60 # minutes

# transparent hugepages and merging same pages cause major IOPS jitter
sudo /bin/sh -c 'echo madvise > /sys/kernel/mm/transparent_hugepage/enabled'
sudo /bin/sh -c 'echo 0 > /sys/kernel/mm/ksm/run'

if sudo rbd showmapped | grep -q "${IMAGE##*/}"; then
	bdev=$(readlink -f "/dev/rbd/$IMAGE")
	sudo rbd unmap "$bdev"
fi

if rbd info "$IMAGE" >/dev/null 2>&1; then
	rbd rm "$IMAGE"
fi

rbd create \
	--image-format 2 \
	--image-feature layering \
	--size ${IMG_SIZE}G \
	"$IMAGE"

sudo rbd map --id admin --keyring /etc/ceph/ceph.client.admin.keyring "$IMAGE"
bdev=$(readlink -f "/dev/rbd/$IMAGE")
sudo chown `whoami` "$bdev"

cat > krbd-guest.fio <<-EOF
[global]
write_bw_log=krbd-guest-bw.log
write_iops_log=krbd-guest-iops.log
ioengine=libaio
rw=randwrite
direct=1
bs=4k
runtime=$((DURATION*60))

[krbd_iodepth32]
iodepth=32
filename=$bdev
EOF

sudo env LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.1 fio krbd-guest.fio
sudo rbd unmap "$bdev"
