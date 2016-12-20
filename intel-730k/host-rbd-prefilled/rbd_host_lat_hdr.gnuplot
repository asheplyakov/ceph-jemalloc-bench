set terminal png size 1280, 720
set output 'rbd_host_lat_hdr.png'
set logscale x
unset xtics
set title 'rbd 4KB randwrite, prefilled image'
set xlabel 'Percentile'
set ylabel 'Latency, msec'
set key top left
plot \
	'rbd_host_lat_hdr.log' using 4:1 with lines notitle, \
	'-' with labels center offset 0, 0.5 point
1 0.0 0%
10 0.0 90%
100 0.0 99%
1000 0.0 99.9%
10000 0.0 99.99%
100000 0.0 99.999%
1000000 0.0 99.9999%
e
