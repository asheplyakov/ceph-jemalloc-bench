#!/bin/sh
set -e

gnuplot - <<-EOF
set term png;
set output "qemu_krbd_iops.png";
set title 'fio 4KB randwrite, all CPUs';
set xlabel 'time, seconds';
set ylabel 'IOPS';
set yrange [0:8000];
plot '../fio-host/rbd-host-iops.log_iops.1.log' using (\$1/1000.0):(\$2) with lines title 'host ioengine rbd', \
     'krbd-guest-iops.log_iops.1.log' using (\$1/1000.0):(\$2) with lines title 'VM+krbd, ioengine libaio';
EOF

gnuplot - <<-EOF
set term png;
set output "qemu_krbd_bw.png";
set title 'fio 4KB randwrite, all CPUs';
set xlabel 'time, seconds';
set ylabel 'Bandwidth, KB/sec';
plot '../fio-host/rbd-host-bw.log_bw.1.log' using (\$1/1000.0):(\$2) with lines title 'host, ioengine rbd',\
     'krbd-guest-bw.log_bw.1.log' using (\$1/1000.0):(\$2) with lines title 'VM+krbd, ioengine libaio';
EOF

