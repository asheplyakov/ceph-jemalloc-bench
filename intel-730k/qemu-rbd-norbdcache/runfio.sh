#!/bin/sh
set -e
bdev="/dev/vdc"
JOBFILE="vdc.fio"
DURATION=$((60*3)) # 3 hours

# transparent hugepages and merging same pages cause major IOPS jitter
sudo /bin/sh -c 'echo madvise > /sys/kernel/mm/transparent_hugepage/enabled'
sudo /bin/sh -c 'echo 0 > /sys/kernel/mm/ksm/run'
sudo apt-get install -y libjemalloc1

cat > "$JOBFILE"  <<-EOF
[global]
write_bw_log=qemu-rbd-bw.log
write_iops_log=qemu-rbd-iops.log
write_lat_log=qemu-rbd-lat.log
ioengine=libaio
rw=randwrite
direct=1
bs=4k
runtime=$((DURATION*60))

[qemu_rbd_iodepth8]
iodepth=8
filename=$bdev
EOF

exec sudo env LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.1 fio "$JOBFILE"
