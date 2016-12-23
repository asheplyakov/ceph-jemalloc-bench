set terminal png size 1280, 720
set output 'qemu_rbd_lat_hdr.png'
set logscale x
set logscale y
set yrange [0.1:12000]
unset xtics
set ylabel 'Latency, msec'
set xlabel 'Percentile'
set title '4KB randwrite, prefilled rbd image'
set key top left
plot \
	'qemu_rbd_lat_hdr.log' using 4:1 with lines title 'VM, ioengine=libaio', \
	'../host-rbd-prefilled/rbd_host_lat_hdr.log' using 4:1 with lines title 'host, ioengine=rbd', \
	'-' with labels center offset 0.2, 0.5  point notitle, \
	'-' with lines title 'VM, average', \
	'-' with lines title 'host, average'
1 0.1 0%
10 0.1 90%
100 0.1 99%
1000 0.1 99.9%
10000 0.1 99.99%
100000 0.1 99.999%
1000000 0.1 99.9999%
e
1 2.859 0%
10 2.859 90%
100 2.859 99%
1000 2.859 99.9%
10000 2.859  99.99%
100000 2.859 99.999%
1000000 2.859 99.9999%
4300000 2.859 99.99999%
e
1 3.036 0%
10 3.036 90%
100 3.036 99%
1000 3.036 99.9%
10000 3.036  99.99%
100000 3.036 99.999%
1000000 3.036 99.9999%
4300000 3.036 99.99999%
e

