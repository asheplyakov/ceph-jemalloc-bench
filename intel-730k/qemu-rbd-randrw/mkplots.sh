#!/bin/sh
set -e

maybe_uncompress () {
	local compressed="$1"
	if [ -f "$compressed" ]; then
		xz -f -d -k "$compressed"
	fi
}

gnuplot qemu_rbd_randrw_hdr.gnuplot

logfile="qemu-rbd-bw.log_bw.1.log"
maybe_uncompress "${logfile}.xz"
tmp_plot="qemu_rbd_randrw_bw_$$.png"
TEST_NAME='rbd 4KB randrw, prefilled image, rbd and drive write caches ENABLED'

gnuplot - <<-EOF
set term png;
set output "$tmp_plot";
set title '$TEST_NAME';
set xlabel 'time, seconds';
set ylabel 'Bandwidth, KB/sec';
plot \
	'<(grep -e "\<0\>, 4096" $logfile)' using (\$1/1000.0):(\$2) with lines title 'reads',\
	'<(grep -e "\<1\>, 4096" $logfile)' using (\$1/1000.0):(\$2) with lines title 'writes';
EOF

mv "$tmp_plot" "qemu_rbd_randrw_bw.png"

logfile="qemu-rbd-iops.log_iops.1.log"
maybe_uncompress "${logfile}.xz"
tmp_plot="qemu_rbd_randrw_iops_$$.png"

gnuplot - <<-EOF
set term png;
set output "$tmp_plot";
set title '$TEST_NAME';
set xlabel 'time, seconds';
set ylabel 'IOPS';
plot \
	'<(grep -e "\<0\>, 4096" $logfile)' using (\$1/1000.0):(\$2) with lines title 'reads',\
	'<(grep -e "\<1\>, 4096" $logfile)' using (\$1/1000.0):(\$2) with lines title 'writes';
EOF

mv "$tmp_plot" "qemu_rbd_randrw_iops.png"

logfile="qemu-rbd-lat.log_lat.1.log"
maybe_uncompress "${logfile}.xz"
maybe_uncompress "../host-rbd-prefilled-randrw-wc/rbd_randrw_lat.log_lat.1.log.xz"
tmp_plot="qemu_rbd_randrw_lat_$$.png"

gnuplot - <<-EOF
set term png;
set output "$tmp_plot";
set title '$TEST_NAME';
set xlabel 'time, seconds';
set ylabel 'Latency, usec';
plot \
	'<(grep -e "\<0\>, 4096" $logfile)' using (\$1/1000.0):(\$2) with lines title 'guest virtual HD reads',\
	'<(grep -e "\<1\>, 4096" $logfile)' using (\$1/1000.0):(\$2) with lines title 'guest virtual HD writes', \
	'<(grep -e "\<0\>, 4096" ../host-rbd-prefilled-randrw-wc/rbd_randrw_lat.log_lat.1.log)' \
		using (\$1/1000.0):(\$2) with lines title 'rbd reads',\
	'<(grep -e "\<1\>, 4096" ../host-rbd-prefilled-randrw-wc/rbd_randrw_lat.log_lat.1.log)' \
		using (\$1/1000.0):(\$2) with lines title 'rbd writes';
EOF

mv "$tmp_plot" "qemu_rbd_randrw_lat.png"

