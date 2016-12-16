#!/bin/sh
set -e

maybe_uncompress () {
	local compressed="$1"
	if [ -f "$compressed" ]; then
		xz -f -d -k "$compressed"
	fi
}

logfile="rbd-host-bw.log_bw.1.log"
maybe_uncompress "${logfile}.xz"
tmp_plot="host_rbd_bw_$$.png"
TEST_NAME='fio ioengine rbd 4KB randwrite, prefilled image'

gnuplot - <<-EOF
set term png;
set output "$tmp_plot";
set title '$TEST_NAME';
set xlabel 'time, seconds';
set ylabel 'Bandwidth, KB/sec';
plot \
	'$logfile' using (\$1/1000.0):(\$2) with lines notitle;
EOF

mv "$tmp_plot" "host_rbd_bw.png"


logfile="rbd-host-iops.log_iops.1.log"
maybe_uncompress "${logfile}.xz"
tmp_plot="host_rbd_iops_$$.png"

gnuplot - <<-EOF
set term png;
set output "$tmp_plot";
set title '$TEST_NAME';
set xlabel 'time, seconds';
set ylabel 'IOPS';
plot \
	'$logfile' using (\$1/1000.0):(\$2) with lines notitle;
EOF

mv "$tmp_plot" "host_rbd_iops.png"

logfile="rbd-host-lat.log_lat.1.log"
maybe_uncompress "${logfile}.xz"
tmp_plot="host_rbd_lat_$$.png"

gnuplot - <<-EOF
set term png;
set output "$tmp_plot";
set title '$TEST_NAME';
set xlabel 'time, seconds';
set ylabel 'Latency, usec';
plot \
	'$logfile' using (\$1/1000.0):(\$2) with lines notitle;
EOF

mv "$tmp_plot" "host_rbd_lat.png"



