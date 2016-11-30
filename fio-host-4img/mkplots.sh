#!/bin/sh
set -e

gnuplot - <<-EOF
set term png;
set output "host_rbd_4img_iops.png";
set title 'fio ioengine rbd 4KB randwrite, 4 images, NUMA node #0';
set xlabel 'time, seconds';
set ylabel 'IOPS';
plot \
	'rbd-host-4img-iops.log_iops.1.log' using (\$1/1000.0):(\$2) with lines title 'image #1', \
	'rbd-host-4img-iops.log_iops.2.log' using (\$1/1000.0):(\$2) with lines title 'image #2', \
	'rbd-host-4img-iops.log_iops.3.log' using (\$1/1000.0):(\$2) with lines title 'image #3', \
	'rbd-host-4img-iops.log_iops.4.log' using (\$1/1000.0):(\$2) with lines title 'image #4';
EOF

gnuplot - <<-EOF
set term png;
set output "host_rbd_4img_bw.png";
set title 'fio ioengine rbd 4KB randwrite, 4 images, NUMA node #0';
set xlabel 'time, seconds';
set ylabel 'Bandwidth, KB/sec';
plot \
	'rbd-host-4img-bw.log_bw.1.log' using (\$1/1000.0):(\$2) with lines title 'image #1', \
	'rbd-host-4img-bw.log_bw.2.log' using (\$1/1000.0):(\$2) with lines title 'image #2', \
	'rbd-host-4img-bw.log_bw.3.log' using (\$1/1000.0):(\$2) with lines title 'image #3', \
	'rbd-host-4img-bw.log_bw.4.log' using (\$1/1000.0):(\$2) with lines title 'image #4';
EOF

