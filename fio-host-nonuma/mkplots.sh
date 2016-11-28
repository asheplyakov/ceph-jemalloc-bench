#!/bin/sh
set -e

gnuplot - <<-EOF
set term png;
set output "host_rbd_fio_iops.png";
set title 'fio ioengine rbd, 4KB randwrite';
set xlabel 'time, seconds';
set ylabel 'IOPS';
plot '../fio-host/rbd-host-iops.log_iops.1.log' using (\$1/1000.0):(\$2) with lines title 'all cores', \
     'rbd-host-iops.log_iops.1.log' using (\$1/1000.0):(\$2) with lines title 'NUMA node #0';
EOF

gnuplot - <<-EOF
set term png;
set output "host_rbd_fio_bw.png";
set title 'fio ioengine rbd, 4KB randwrite';
set xlabel 'time, seconds';
set ylabel 'Bandwidth, KB/sec';
plot '../fio-host/rbd-host-bw.log_bw.1.log' using (\$1/1000.0):(\$2) with lines title 'all cores', \
     'rbd-host-bw.log_bw.1.log' using (\$1/1000.0):(\$2) with lines title 'NUMA node #0';
EOF

