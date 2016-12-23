#!/bin/sh
set -e

# xz -f -d -k qemu-rbd-bw.log_bw.1.log.xz

gnuplot - <<-EOF
set term png;
set output "qemu_rbd_bw_$$.png";
set title 'rbd virtual HD (prefilled), fio ioengine libaio, 4KB randwrite';
set xlabel 'time, seconds';
set ylabel 'Bandwidth, KB/sec';
plot \
	'qemu-rbd-bw.log_bw.1.log' using (\$1/1000.0):(\$2) with lines notitle;
EOF

mv "qemu_rbd_bw_$$.png" "qemu_rbd_bw.png"

# xz -f -d -k qemu-rbd-iops.log_iops.1.log.xz

gnuplot - <<-EOF
set term png;
set output "qemu_rbd_iops_$$.png";
set title 'rbd virtual HD (prefilled), fio ioengine libaio, 4KB randwrite';
set xlabel 'time, seconds';
set ylabel 'IOPS';
plot \
	'qemu-rbd-iops.log_iops.1.log' using (\$1/1000.0):(\$2) with lines notitle;
EOF

mv "qemu_rbd_iops_$$.png" "qemu_rbd_iops.png"

# xz -d -k "qemu-rbd-lat.log_lat.1.log.xz"

gnuplot - <<-EOF
set term png;
set output "qemu_rbd_lat_$$.png";
set title 'rbd virtual HD (prefilled), fio ioengine libaio, 4KB randwrite';
set xlabel 'time, seconds';
set ylabel 'Latency, usec';
plot \
	'qemu-rbd-lat.log_lat.1.log' using (\$1/1000.0):(\$2) with lines notitle;
EOF

mv "qemu_rbd_lat_$$.png" "qemu_rbd_lat.png"



