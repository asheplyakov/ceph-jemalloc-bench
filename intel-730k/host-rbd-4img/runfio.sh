#!/bin/sh
set -e
MYDIR="${0%/*}"
POOL='rbd'
IMG_SIZE=30 # GB
IMG_COUNT=4
DURATION=240 # 4 hours
JOBFILE="rbd-host-4im.fio"

# transparent hugepages and merging same pages cause major IOPS jitter
sudo /bin/sh -c 'echo madvise > /sys/kernel/mm/transparent_hugepage/enabled'
sudo /bin/sh -c 'echo 0 > /sys/kernel/mm/ksm/run'
cpu_count=`nproc`
for i in `seq 0 $((cpu_count-1))`; do
	sudo /bin/sh -c "echo performance > /sys/devices/system/cpu/cpu${i}/cpufreq/scaling_governor"
done

cat > "$JOBFILE" <<-EOF
[global]
write_bw_log=rbd_4img_bw.log
write_iops_log=rbd_4img_iops.log
write_lat_log=rbd_4img_lat.log
ioengine=rbd
rw=randwrite
bs=4k
direct=1
invalidate=0
pool=$POOL
clientname=admin
runtime=$((DURATION*60))
EOF

for n in `seq 0 $((IMG_COUNT-1))`; do
	IMAGE="rbd/`hostname`-fio-vol${n}.img"
	IMAGES="${IMAGES} ${IMAGE}"
	if ! rbd info "$IMAGE" >/dev/null 2>&1; then
		rbd create \
			--image-format 2 \
			--image-feature layering \
			--size ${IMG_SIZE}G \
			"$IMAGE"
	fi
	cat >> "$JOBFILE" <<-EOF
	[rbd_$n]
	rbdname=${IMAGE##*/}
	iodepth=2
	EOF
	$MYDIR/../../scripts/fill_rbd_image.py "$IMAGE"
done

exec \
	env \
		LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.1 \
			fio "$JOBFILE"
