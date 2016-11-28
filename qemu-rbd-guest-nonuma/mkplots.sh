#!/bin/sh
set -e

gnuplot - <<-EOF
set term png;
set output "qemu_rbd_fio_iops.png";
set title 'qemu + rbd VHD (cache: writeback), fio ioengine libaio, 4KB randwrite';
set xlabel 'time, seconds';
set ylabel 'IOPS';
plot '../qemu-rbd-guest/qemu-rbd-iops.log_iops.1.log' using (\$1/1000.0):(\$2) with lines title 'all cores', \
     'qemu-rbd-iops.log_iops.1.log' using (\$1/1000.0):(\$2) with lines title 'NUMA node #0';
EOF

gnuplot - <<-EOF
set term png;
set output "qemu_rbd_fio_bw.png";
set title 'qemu + rbd VHD (cache: writeback), fio ioengine libaio, 4KB randwrite';
set xlabel 'time, seconds';
set ylabel 'Bandwidth, KB/sec';
plot '../qemu-rbd-guest/qemu-rbd-bw.log_bw.1.log' using (\$1/1000.0):(\$2) with lines title 'all cores', \
     'qemu-rbd-bw.log_bw.1.log' using (\$1/1000.0):(\$2) with lines title 'NUMA node #0';
EOF
