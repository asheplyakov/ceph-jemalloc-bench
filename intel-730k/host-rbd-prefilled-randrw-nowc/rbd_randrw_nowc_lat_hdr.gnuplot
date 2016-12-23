set terminal png size 1280, 720
set output 'rbd_randrw_nowc_lat_hdr.png'
set title 'rbd 4KB randrw, prefilled images, caches disabled (both rbd and SSD)'
set logscale x
set xlabel 'Percentile'
set ylabel 'Latency, msec'
unset xtics
set key top left
plot 'rbd_randrw_nowc_read_lat_hdr.log' using 4:1 with lines title 'reads, drives write cache DISABLED',\
     'rbd_randrw_nowc_write_lat_hdr.log' using 4:1 with lines title 'writes, drives write cache DISABLED',\
     '../host-rbd-prefilled-randrw-wc/rbd_randrw_wc_lat_hdr_r.log' using 4:1 with lines title 'reads, drives write cache ENABLED',\
     '../host-rbd-prefilled-randrw-wc/rbd_randrw_wc_lat_hdr_w.log' using 4:1 with lines title 'writes, drives write cache ENABLED',\
	'-' with labels center offset 0, 0.5 point notitle
1 0.0 0%
10 0.0 90%
100 0.0 99%
1000 0.0 99.9%
10000 0.0 99.99%
100000 0.0 99.999%
1000000 0.0 99.9999%
e

set output 'rbd_randrw_nowc_lat_hdr_log.png'
set title 'rbd 4KB randrw, prefilled images, caches disabled (both rbd and SSD)'
set xlabel 'Percentile'
set ylabel 'Latency, msec'
set logscale y
set logscale x
unset xtics
set key top left
plot 'rbd_randrw_nowc_read_lat_hdr.log' using 4:1 with lines title 'reads, drives write cache DISABLED',\
     'rbd_randrw_nowc_write_lat_hdr.log' using 4:1 with lines title 'writes, drives write cache DISABLED',\
     '../host-rbd-prefilled-randrw-wc/rbd_randrw_wc_lat_hdr_r.log' using 4:1 with lines title 'reads, drives write cache ENABLED',\
     '../host-rbd-prefilled-randrw-wc/rbd_randrw_wc_lat_hdr_w.log' using 4:1 with lines title 'writes, drives write cache ENABLED',\
	'-' with labels center offset 0, 0.5 point notitle
1 0.1 0%
10 0.1 90%
100 0.1 99%
1000 0.1 99.9%
10000 0.1 99.99%
100000 0.1 99.999%
1000000 0.1 99.9999%
e


