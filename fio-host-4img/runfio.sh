#!/bin/sh
set -e
IMG_SIZE=512 # GB
TOTAL_IO_DEPTH=32
IMG_COUNT=4
DURATION=120 # minutes
FIO_JOBFILE="rbd-host-${IMG_COUNT}img.fio"
numa_bind='block:sdh'

# transparent hugepages and merging same pages cause major IOPS jitter
sudo /bin/sh -c 'echo madvise > /sys/kernel/mm/transparent_hugepage/enabled'
sudo /bin/sh -c 'echo 0 > /sys/kernel/mm/ksm/run'

cat > "$FIO_JOBFILE" <<-EOF
[global]
write_bw_log=rbd-host-${IMG_COUNT}img-bw.log
write_iops_log=rbd-host-${IMG_COUNT}img-iops.log
ioengine=rbd
rw=randwrite
bs=4k
clientname=admin
pool=rbd
invalidate=0
runtime=$((DURATION*60))

EOF

for i in  `seq 0 $((IMG_COUNT-1))`; do
	img_name="rbd/`hostname`-fio-vol${i}.img"
	if rbd info "$img_name" >/dev/null 2>&1; then
		rbd rm "$img_name"
	fi
	rbd create \
		--image-format 2 \
		--image-feature layering \
		--size ${IMG_SIZE}G \
		"$img_name"
	cat >> "$FIO_JOBFILE" <<-EOF
	[job${i}]
	rbdname=${img_name##*/}
	iodepth=$((TOTAL_IO_DEPTH/IMG_COUNT))
	EOF
done

exec numactl --membind ${numa_bind} \
	--cpunodebind ${numa_bind} \
	env \
		LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.1 \
		fio "$FIO_JOBFILE"
