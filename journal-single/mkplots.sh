#!/bin/sh
set -e

gzip -k -d journal_single_iops**.log.gz

gnuplot - <<-EOF
set term png;
set output "single_journal_iops.png";
set title 'journal, single 4KB O_DSYNC write';
set xlabel 'time, seconds';
set ylabel 'IOPS';
plot \
	'journal_single_iops.log_iops.1.log' using(\$1/1000.0):(\$2) with lines notitle;
EOF

gzip -k -d journal_single_bw*.log.gz

gnuplot - <<-EOF
set term png;
set output "single_journal_bw.png";
set title 'journal, single 4KB O_DSYNC write';
set xlabel 'time, seconds';
set ylabel 'Bandwidth, KB/sec';
plot \
	'journal_single_bw.log_bw.1.log' using(\$1/1000.0):(\$2) with lines notitle;
EOF

xz -k -d journal_single_lat*.log.xz

gnuplot - <<-EOF
set term png;
set output "single_journal_latency.png";
set title 'journal, single 4KB O_DSYNC write';
set xlabel 'time, seconds';
set ylabel 'Latency, usec';
plot \
	'journal_single_lat.log_lat.1.log' using(\$1/1000.0):(\$2) with lines notitle;
EOF

