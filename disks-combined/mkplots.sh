#!/bin/sh
set -e

gzip -k -d combined_iops*.log.gz

gnuplot - <<-EOF
set term png;
set output "combined_journal_iops.png";
set title 'journal, 4KB O_DSYNC write';
set xlabel 'time, seconds';
set ylabel 'IOPS';
plot \
	'combined_iops.log_iops.1.log' using(\$1/1000.0):(\$2) with lines title 'partition 1',\
	'combined_iops.log_iops.2.log' using(\$1/1000.0):(\$2) with lines title 'partition 2',\
	'combined_iops.log_iops.3.log' using(\$1/1000.0):(\$2) with lines title 'partition 3',\
	'combined_iops.log_iops.4.log' using(\$1/1000.0):(\$2) with lines title 'partition 4';
EOF

gnuplot - <<-EOF
set term png;
set output "combined_data_iops.png";
set title 'data, 4KB randwrite';
set xlabel 'time, seconds';
set ylabel 'IOPS';
plot \
	'combined_iops.log_iops.5.log' using(\$1/1000.0):(\$2) with lines title 'sdz',\
	'combined_iops.log_iops.6.log' using(\$1/1000.0):(\$2) with lines title 'sdy',\
	'combined_iops.log_iops.7.log' using(\$1/1000.0):(\$2) with lines title 'sdx',\
	'combined_iops.log_iops.8.log' using(\$1/1000.0):(\$2) with lines title 'sdw',\
	'combined_iops.log_iops.9.log' using(\$1/1000.0):(\$2) with lines title 'sdv',\
	'combined_iops.log_iops.10.log' using(\$1/1000.0):(\$2) with lines title 'sdu',\
	'combined_iops.log_iops.11.log' using(\$1/1000.0):(\$2) with lines title 'sdt';
EOF

gzip -k -d combined_bw*.log.gz

gnuplot - <<-EOF
set term png;
set output "combined_journal_bw.png";
set title 'journal, 4KB O_DSYNC write';
set xlabel 'time, seconds';
set ylabel 'Bandwidth, KB/sec';
plot \
	'combined_bw.log_bw.1.log' using(\$1/1000.0):(\$2) with lines title 'partition 1',\
	'combined_bw.log_bw.2.log' using(\$1/1000.0):(\$2) with lines title 'partition 2',\
	'combined_bw.log_bw.3.log' using(\$1/1000.0):(\$2) with lines title 'partition 3',\
	'combined_bw.log_bw.4.log' using(\$1/1000.0):(\$2) with lines title 'partition 4';
EOF

gzip -k -d combined_lat*.log.gz

gnuplot - <<-EOF
set term png;
set output "combined_journal_latency.png";
set title 'journal, 4KB O_DSYNC write';
set xlabel 'time, seconds';
set ylabel 'Latency, usec';
plot \
	'combined_lat.log_lat.1.log' using(\$1/1000.0):(\$2) with lines title 'partition 1',\
	'combined_lat.log_lat.2.log' using(\$1/1000.0):(\$2) with lines title 'partition 2',\
	'combined_lat.log_lat.3.log' using(\$1/1000.0):(\$2) with lines title 'partition 3',\
	'combined_lat.log_lat.4.log' using(\$1/1000.0):(\$2) with lines title 'partition 4';
EOF


gnuplot - <<-EOF
set term png;
set output "combined_data_latency.png";
set title 'data, 4KB randwrite';
set xlabel 'time, seconds';
set ylabel 'Latency, usec';
plot \
	'combined_lat.log_lat.5.log' using(\$1/1000.0):(\$2) with lines title 'sdz',\
	'combined_lat.log_lat.6.log' using(\$1/1000.0):(\$2) with lines title 'sdy',\
	'combined_lat.log_lat.7.log' using(\$1/1000.0):(\$2) with lines title 'sdx',\
	'combined_lat.log_lat.8.log' using(\$1/1000.0):(\$2) with lines title 'sdw',\
	'combined_lat.log_lat.9.log' using(\$1/1000.0):(\$2) with lines title 'sdv',\
	'combined_lat.log_lat.10.log' using(\$1/1000.0):(\$2) with lines title 'sdu',\
	'combined_lat.log_lat.11.log' using(\$1/1000.0):(\$2) with lines title 'sdt';
EOF

