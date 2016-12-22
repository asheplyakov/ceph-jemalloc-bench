#!/bin/sh
set -e

maybe_uncompress () {
	local compressed="$1"
	if [ -f "$compressed" ]; then
		xz -f -d -k "$compressed"
	fi
}

gnuplot - <<-EOF
set terminal png size 1280, 720
set output 'rbd_4img_lat_hdr.png'
set logscale x
set title 'rbd 4KB randwrite, 4 writers, prefilled images';
set ylabel 'Latency, msec'
set xlabel 'Percentile'
unset xtics
set key top left
plot \
	'rbd_4img_lat_hdr_1.log' using 4:1 with lines title 'image 1', \
	'rbd_4img_lat_hdr_2.log' using 4:1 with lines title 'image 2', \
	'rbd_4img_lat_hdr_3.log' using 4:1 with lines title 'image 3', \
	'rbd_4img_lat_hdr_4.log' using 4:1 with lines title 'image 4', \
	'../host-rbd-prefilled/rbd_host_lat_hdr.log' using 4:1 with lines title 'single image', \
	'-' with labels center offset 0, 0.5 point notitle
1 0.0 0%
10 0.0 90%
100 0.0 99%
1000 0.0 99.9%
10000 0.0 99.99%
100000 0.0 99.999%
1000000 0.0 99.9999%
e
EOF

for i in `seq 1 4`; do
	maybe_uncompress "rbd_4img_bw.log_bw.${i}.log.xz"
done

gnuplot - <<-EOF
set term png;
set output "rbd_4img_bw.png";
set title 'rbd 4KB randwrite, 4 writers, prefilled images';
set xlabel 'time, seconds';
set ylabel 'Bandwidth, KB/sec';
plot \
	'rbd_4img_bw.log_bw.1.log' using (\$1/1000.0):(\$2) with lines title 'image #1', \
	'rbd_4img_bw.log_bw.2.log' using (\$1/1000.0):(\$2) with lines title 'image #2', \
	'rbd_4img_bw.log_bw.3.log' using (\$1/1000.0):(\$2) with lines title 'image #3', \
	'rbd_4img_bw.log_bw.4.log' using (\$1/1000.0):(\$2) with lines title 'image #4';
EOF

for i in `seq 1 4`; do
	maybe_uncompress "rbd_4img_iops.log_iops.${i}.log.xz"
done

gnuplot - <<-EOF
set term png;
set output "rbd_4img_iops.png";
set title 'rbd 4KB randwrite, 4 writers, prefilled images';
set xlabel 'time, seconds';
set ylabel 'IOPS';
plot \
	'rbd_4img_iops.log_iops.1.log' using (\$1/1000.0):(\$2) with lines title 'image #1', \
	'rbd_4img_iops.log_iops.2.log' using (\$1/1000.0):(\$2) with lines title 'image #2', \
	'rbd_4img_iops.log_iops.3.log' using (\$1/1000.0):(\$2) with lines title 'image #3', \
	'rbd_4img_iops.log_iops.4.log' using (\$1/1000.0):(\$2) with lines title 'image #4';
EOF

for i in `seq 1 4`; do
	maybe_uncompress "rbd_4img_lat.log_lat.${i}.log.xz"
done

gnuplot - <<-EOF
set term png;
set output "rbd_4img_lat.png";
set title 'rbd 4KB randwrite, 4 writers, prefilled images';
set xlabel 'time, seconds';
set ylabel 'Latency, msec';
plot \
	'rbd_4img_lat.log_lat.1.log' using (\$1/1000.0):(\$2/1000.0) with lines title 'image #1', \
	'rbd_4img_lat.log_lat.2.log' using (\$1/1000.0):(\$2/1000.0) with lines title 'image #2', \
	'rbd_4img_lat.log_lat.3.log' using (\$1/1000.0):(\$2/1000.0) with lines title 'image #3', \
	'rbd_4img_lat.log_lat.4.log' using (\$1/1000.0):(\$2/1000.0) with lines title 'image #4';
EOF



