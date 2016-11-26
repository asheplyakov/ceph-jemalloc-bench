#!/bin/sh
set -e
bdev="/dev/vdc"

# transparent hugepages and merging same pages cause major IOPS jitter
sudo /bin/sh -c 'echo madvise > /sys/kernel/mm/transparent_hugepage/enabled'
sudo /bin/sh -c 'echo 0 > /sys/kernel/mm/ksm/run'
sudo apt-get install -y libjemalloc1

cat > qemu-rbd.fio <<-EOF
[global]
write_bw_log=qemu-rbd-bw.log
write_iops_log=qemu-rbd-iops.log
ioengine=libaio
rw=randwrite
direct=1
bs=4k
runtime=$((DURATION*60))

[krbd_iodepth32]
iodepth=32
filename=$bdev
EOF

sudo env LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.1 fio qemu-rbd.fio
