#!/bin/sh
set -e
gnuplot - <<-EOF
set term png;
set output 'host_rbd_iops_hist.png';
set title 'fio ioengine=rbd IOPS distribution';
set xlabel 'IOPS';
set ylabel 'event count';
binwidth=10;
bin(x, width)=width*floor(x/width);
plot '../fio-host/rbd-host-iops.log_iops.1.log' using (bin(\$2,binwidth)):(1.0) smooth freq with boxes title 'all CPUs',\
     'rbd-host-iops.log_iops.1.log' using (bin(\$2,binwidth)):(1.0) smooth freq with boxes title 'NUMA node #0'
EOF

gnuplot - <<-EOF
set term png;
set output 'host_rbd_latency_nonuma_hist.png';
binwidth=1e-3;
bin(x, width)=width*floor(x/width);
latency_msec(x)=1000.0/x;
set title 'fio ioengine=rbd latency distribution';
set xlabel 'latency, msec';
set ylabel 'event count';
plot 'rbd-host-iops.log_iops.1.log' using (bin(latency_msec(\$2),binwidth)):(1.0) smooth freq with boxes title 'NUMA node #0';
EOF
