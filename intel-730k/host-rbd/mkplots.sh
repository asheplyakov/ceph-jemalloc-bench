#!/bin/sh
set -e

xz -f -d -k rbd-host-bw.log_bw.1.log.xz

gnuplot - <<-EOF
set term png;
set output "host_rbd_bw_$$.png";
set title 'fio ioengine rbd 4KB randwrite';
set xlabel 'time, seconds';
set ylabel 'Bandwidth, KB/sec';
plot \
	'rbd-host-bw.log_bw.1.log' using (\$1/1000.0):(\$2) with lines notitle;
EOF

mv "host_rbd_bw_$$.png" "host_rbd_bw.png"


xz -f -d -k rbd-host-iops.log_iops.1.log.xz

gnuplot - <<-EOF
set term png;
set output "host_rbd_iops_$$.png";
set title 'fio ioengine rbd 4KB randwrite';
set xlabel 'time, seconds';
set ylabel 'IOPS';
plot \
	'rbd-host-iops.log_iops.1.log' using (\$1/1000.0):(\$2) with lines notitle;
EOF

mv "host_rbd_iops_$$.png" "host_rbd_iops.png"

# xz -d -k "rbd-host-lat.log_lat.1.log.xz"

gnuplot - <<-EOF
set term png;
set output "host_rbd_lat_$$.png";
set title 'fio ioengine rbd 4KB randwrite';
set xlabel 'time, seconds';
set ylabel 'Latency, usec';
plot \
	'rbd-host-lat.log_lat.1.log' using (\$1/1000.0):(\$2) with lines notitle;
EOF

mv "host_rbd_lat_$$.png" "host_rbd_lat.png"



