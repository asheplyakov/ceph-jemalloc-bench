#!/bin/sh
set -e
IMAGE="rbd/`hostname`-fio-vol00.img"
IMG_SIZE=120 # GB
DURATION=240 # 4 hours
JOBFILE="rbd-host.fio"

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
fi

cat > "$JOBFILE" <<-EOF
[global]
write_bw_log=rbd-host-bw.log
write_iops_log=rbd-host-iops.log
write_lat_log=rbd-host-lat.log
ioengine=rbd
rw=randwrite
bs=4k
clientname=admin
pool=${IMAGE%%/*}
invalidate=0
runtime=$((DURATION*60))

[rbd_iodepth8]
rbdname=${IMAGE##*/}
iodepth=8
EOF

exec \
	env \
		LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.1 \
			fio "$JOBFILE"
