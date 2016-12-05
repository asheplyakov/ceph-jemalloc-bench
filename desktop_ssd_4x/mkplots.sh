#!/bin/sh
set -e

xz -k -d journal4x_bw.log_bw.*.log.xz
gnuplot - <<-EOF
set term png;
set output "desktop_ssd_4x_bw.png";
set title 'Desktop SSD, 4KB O_DSYNC write, 4 writers';
set xlabel 'time, seconds';
set ylabel 'Bandwidth, KB/sec';
plot \
	'journal4x_bw.log_bw.1.log' using(\$1/1000.0):(\$2) with lines title 'partition 1',\
	'journal4x_bw.log_bw.2.log' using(\$1/1000.0):(\$2) with lines title 'partition 2',\
	'journal4x_bw.log_bw.3.log' using(\$1/1000.0):(\$2) with lines title 'partition 3',\
	'journal4x_bw.log_bw.4.log' using(\$1/1000.0):(\$2) with lines title 'partition 4';
EOF

xz -k -d journal4x_iops.log_iops.*.log.xz
gnuplot - <<-EOF
set term png;
set output "desktop_ssd_4x_iops.png";
set title 'Desktop SSD, 4KB O_DSYNC write, 4 writers';
set xlabel 'time, seconds';
set ylabel 'IOPS';
plot \
	'journal4x_iops.log_iops.1.log' using(\$1/1000.0):(\$2) with lines title 'partition 1',\
	'journal4x_iops.log_iops.2.log' using(\$1/1000.0):(\$2) with lines title 'partition 2',\
	'journal4x_iops.log_iops.3.log' using(\$1/1000.0):(\$2) with lines title 'partition 3',\
	'journal4x_iops.log_iops.4.log' using(\$1/1000.0):(\$2) with lines title 'partition 4';
EOF

xz -k -d journal4x_lat.log_lat.*.log.xz
gnuplot - <<-EOF
set term png;
set output "desktop_ssd_4x_latency.png";
set title 'Desktop SSD, 4KB O_DSYNC write, 4 writers';
set xlabel 'time, seconds';
set ylabel 'Latency, usec';
plot \
	'journal4x_lat.log_lat.1.log' using(\$1/1000.0):(\$2) with lines title 'LV 1',\
	'journal4x_lat.log_lat.2.log' using(\$1/1000.0):(\$2) with lines title 'LV 2',\
	'journal4x_lat.log_lat.3.log' using(\$1/1000.0):(\$2) with lines title 'LV 3',\
	'journal4x_lat.log_lat.4.log' using(\$1/1000.0):(\$2) with lines title 'LV 4';
EOF

