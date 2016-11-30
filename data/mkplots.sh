#!/bin/sh
set -e

gnuplot - <<-EOF
set term png;
set output "host_rot_data_iops.png";
set title 'data, 4KB randwrite';
set xlabel 'time, seconds';
set ylabel 'IOPS';
plot \
	'data_iops.log_iops.1.log' using(\$1/1000.0):(\$2) with lines title 'disk 1',\
	'data_iops.log_iops.2.log' using(\$1/1000.0):(\$2) with lines title 'disk 2',\
	'data_iops.log_iops.3.log' using(\$1/1000.0):(\$2) with lines title 'disk 3',\
	'data_iops.log_iops.4.log' using(\$1/1000.0):(\$2) with lines title 'disk 4',\
	'data_iops.log_iops.5.log' using(\$1/1000.0):(\$2) with lines title 'disk 5',\
	'data_iops.log_iops.6.log' using(\$1/1000.0):(\$2) with lines title 'disk 6';
EOF

gnuplot - <<-EOF
set term png;
set output "host_rot_data_bw.png";
set title 'data, 4KB randwrite';
set xlabel 'time, seconds';
set ylabel 'Bandwidth, KB/sec';
plot \
	'data_bw.log_bw.1.log' using(\$1/1000.0):(\$2) with lines title 'disk 1',\
	'data_bw.log_bw.2.log' using(\$1/1000.0):(\$2) with lines title 'disk 2',\
	'data_bw.log_bw.3.log' using(\$1/1000.0):(\$2) with lines title 'disk 3',\
	'data_bw.log_bw.4.log' using(\$1/1000.0):(\$2) with lines title 'disk 4',\
	'data_bw.log_bw.5.log' using(\$1/1000.0):(\$2) with lines title 'disk 5',\
	'data_bw.log_bw.6.log' using(\$1/1000.0):(\$2) with lines title 'disk 6';
EOF

