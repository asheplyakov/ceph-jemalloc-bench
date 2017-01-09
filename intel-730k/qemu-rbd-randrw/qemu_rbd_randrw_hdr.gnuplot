set terminal pngcairo size 1280, 720
set output 'qemu_rbd_randrw_lat_hdr.png'
set logscale x
set grid
set title 'Guest 4KB randwrite, prefilled image, rbd and drive caches enabled'
unset xtics
set ylabel 'Latency, msec'
set xlabel 'Percentile'
set key top left
plot \
	'qemu_rbd_randrw_read_hdr.log' using 4:1 with lines title 'guest reads', \
	'qemu_rbd_randrw_write_hdr.log' using 4:1 with lines title 'guest writes', \
	'../host-rbd-prefilled-randrw-wc/rbd_randrw_wc_lat_hdr_r.log' using 4:1 with lines title 'rbd reads', \
	'../host-rbd-prefilled-randrw-wc/rbd_randrw_wc_lat_hdr_w.log' using 4:1 with lines title 'rbd writes', \
	'-' with labels center offset 0, 0.5 point notitle;
1 0.0 0%
10 0.0 90%
100 0.0 99%
1000 0.0 99.9%
10000 0.0 99.99%
100000 0.0 99.999%
1000000 0.0 99.9999%
10000000 0.0 99.99999%
e


set terminal pngcairo size 1280, 720
set output 'qemu_rbd_randrw_lat_hdr_log.png'
set grid
set logscale x
set logscale y

plot \
	'qemu_rbd_randrw_read_hdr.log' using 4:1 with lines title 'guest reads', \
	'qemu_rbd_randrw_write_hdr.log' using 4:1 with lines title 'guest writes', \
	'../host-rbd-prefilled-randrw-wc/rbd_randrw_wc_lat_hdr_r.log' using 4:1 with lines title 'rbd reads', \
	'../host-rbd-prefilled-randrw-wc/rbd_randrw_wc_lat_hdr_w.log' using 4:1 with lines title 'rbd writes', \
	'-' with labels center offset 0, 0.5 point notitle, \
	'-' using 1:2 with dots title 'guest reads average', \
	'-' using 1:2 with dots title 'guest writes average';
1 0.1 0%
10 0.1 90%
100 0.1 99%
1000 0.1 99.9%
10000 0.1 99.99%
100000 0.1 99.999%
1000000 0.1 99.9999%
10000000 0.1 99.99999%
e
1 1.497 0%
10 1.497 90%
100 1.497 99%
1000 1.497 99.9%
10000 1.497 99.99%
100000 1.497 99.999%
1000000 1.497 99.9999%
10000000 1.497 99.99999%
e
1 3.213 0%
10 3.213 90%
100 3.213 99%
1000 3.213 99.9%
10000 3.213 99.99%
100000 3.213 99.999%
1000000 3.213 99.9999%
10000000 3.213 99.99999%
e

set terminal pngcairo size 1280, 720
set output 'qemu_rbd_randrw_lat_hdr_9995.png'
unset logscale y
set xrange [1:2000]
unset xtics
set grid
plot \
	'qemu_rbd_randrw_read_hdr.log' using 4:($2 <= 0.9995 ? $1 : 1/0) with lines title 'guest reads', \
	'qemu_rbd_randrw_write_hdr.log' using 4:($2 <= 0.9995 ? $1 : 1/0) with lines title 'guest writes', \
	'../host-rbd-prefilled-randrw-wc/rbd_randrw_wc_lat_hdr_r.log' using 4:($2 <= 0.9995 ? $1 : 1/0) with lines title 'rbd reads', \
	'../host-rbd-prefilled-randrw-wc/rbd_randrw_wc_lat_hdr_w.log' using 4:($2 <= 0.9995 ? $1 : 1/0) with lines title 'rbd writes', \
	'-' with labels center offset 0, 0.5 point notitle;
1 0.0 0%
10 0.0 90%
20 0.0 95%
100 0.0 99%
200 0.0 99.5%
1000 0.0 99.9%
2000 0.0 99.95%
e

