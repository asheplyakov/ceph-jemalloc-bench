set terminal png size 1280, 720
set output 'rbd_host_nowc_lat_hdr.png'
set title 'rbd 4KB randwrite, prefilled images'
set logscale x
set xlabel 'Percentile'
set ylabel 'Latency, msec'
unset xtics
set key top left
plot 'rbd_nowc_lat_hdr.log' using 4:1 with lines title 'drives write cache DISABLED',\
	'../host-rbd-prefilled/rbd_host_lat_hdr.log' using 4:1 with lines title 'drives write cache ENABLED',\
	'-' with labels center offset 0, 0.5 point notitle
1 0.0 0%
10 0.0 90%
100 0.0 99%
1000 0.0 99.9%
10000 0.0 99.99%
100000 0.0 99.999%
1000000 0.0 99.9999%
e

set output 'rbd_host_nowc_lat_hdr_log.png'
set logscale y
set logscale x
plot 'rbd_nowc_lat_hdr.log' using 4:1 with lines title 'drives write cache DISABLED',\
	'../host-rbd-prefilled/rbd_host_lat_hdr.log' using 4:1 with lines title 'drives write cache ENABLED',\
	'-' with labels center offset 0, 0.5 point notitle
1 0.1 0%
10 0.1 90%
100 0.1 99%
1000 0.1 99.9%
10000 0.1 99.99%
100000 0.1 99.999%
1000000 0.1 99.9999%
e


