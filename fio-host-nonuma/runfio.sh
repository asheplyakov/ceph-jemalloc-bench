#!/bin/sh
set -e
IMAGE="rbd/`hostname`-fio-vol00.img"
IMG_SIZE=512 # GB
DURATION=60 # minutes
numa_bind='block:sdh'

# transparent hugepages and merging same pages cause major IOPS jitter
sudo /bin/sh -c 'echo madvise > /sys/kernel/mm/transparent_hugepage/enabled'
sudo /bin/sh -c 'echo 0 > /sys/kernel/mm/ksm/run'

if rbd info "$IMAGE" >/dev/null 2>&1; then
	rbd rm "$IMAGE"
fi

rbd create \
	--image-format 2 \
	--image-feature layering \
	--size ${IMG_SIZE}G \
	"$IMAGE"

cat > rbd-host.fio <<-EOF
[global]
write_bw_log=rbd-host-bw.log
write_iops_log=rbd-host-iops.log
ioengine=rbd
rw=randwrite
bs=4k
clientname=admin
pool=${IMAGE%%/*}
invalidate=0
runtime=$((DURATION*60))

[rbd_iodepth32]
rbdname=${IMAGE##*/}
iodepth=32
EOF

exec numactl --membind ${numa_bind} \
	--cpunodebind ${numa_bind} \
	env \
		LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.1 \
	fio rbd-host.fio
