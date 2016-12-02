#!/bin/sh
set -e

xz -d -k journal_lat.log_lat.1.log.xz

gnuplot - <<-EOF
set term png;
set output "desktop_ssd_syncwrite_latency.png";
set title '4KB O_DSYNC write, desktop SSD';
set xlabel 'time, sec';
set ylabel 'latency, usec';
plot 'journal_lat.log_lat.1.log' using (\$1/1000.0):(\$2) with lines notitle;
EOF

xz -d -k journal_iops.log_iops.1.log.xz

gnuplot - <<-EOF
set term png;
set output "desktop_ssd_syncwrite_iops.png";
set title '4KB O_DSYNC write, desktop SSD';
set xlabel 'time, sec';
set ylabel 'IOPS';
plot 'journal_iops.log_iops.1.log' using (\$1/1000.0):(\$2) with lines notitle;
EOF

xz -d -k journal_bw.log_bw.1.log.xz

gnuplot - <<-EOF
set term png;
set output "desktop_ssd_syncwrite_bw.png";
set title '4KB O_DSYNC write, desktop SSD';
set xlabel 'time, sec';
set ylabel 'Bandwidth, KB/sec';
plot 'journal_bw.log_bw.1.log' using (\$1/1000.0):(\$2) with lines notitle;
EOF
