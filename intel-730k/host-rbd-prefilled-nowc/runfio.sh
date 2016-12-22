#!/bin/sh
set -e
MYDIR="${0%/*}"
IMAGE="rbd/`hostname`-fio-vol00.img"
POOL="${IMAGE%%/*}"
IMG_SIZE=120 # GB
DURATION=240 # 4 hours
JOBFILE="rbd-host-nowc.fio"
DRIVES="/dev/sdb /dev/sdc"

# transparent hugepages and merging same pages cause major IOPS jitter
sudo /bin/sh -c 'echo madvise > /sys/kernel/mm/transparent_hugepage/enabled'
sudo /bin/sh -c 'echo 0 > /sys/kernel/mm/ksm/run'
for drive in $DRIVES; do
	sudo hdparm -W 0 $drive
done
cpu_count=`nproc`
for i in `seq 0 $((cpu_count-1))`; do
	sudo /bin/sh -c "echo performance > /sys/devices/system/cpu/cpu${i}/cpufreq/scaling_governor"
done

cat > "$JOBFILE" <<-EOF
[global]
write_bw_log=rbd_host_nowc_bw.log
write_iops_log=rbd_host_nowc_iops.log
write_lat_log=rbd_host_nowc_lat.log
ioengine=rbd
rw=randwrite
bs=4k
direct=1
invalidate=0
pool=${IMAGE%%/*}
clientname=admin
runtime=$((DURATION*60))

[rbd_iodepth8]
rbdname=${IMAGE##*/}
iodepth=8
EOF

if ! rbd info "$IMAGE" >/dev/null 2>&1; then
	rbd create \
		--image-format 2 \
		--image-feature layering \
		--size ${IMG_SIZE}G \
		"$IMAGE"
	$MYDIR/../../scripts/fill_rbd_image.py "$IMAGE"
fi

exec \
	env \
		LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.1 \
			fio "$JOBFILE"
