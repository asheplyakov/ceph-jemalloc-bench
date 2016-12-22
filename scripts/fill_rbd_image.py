#!/usr/bin/env python2

import rados, rbd, sys


def fill_image(rbdpath,
               conffile='/etc/ceph/ceph.conf'):
    pool, image_name = rbdpath.split('/')
    # scoping rules idiocy: assignment operator marks variable as local
    percentage = [0]
    block_count, block_size = 0, 1 << 22

    def report_progress(n):
        new_percentage = (n * 100) / block_count
        if percentage[0] != new_percentage:
            print("%d%% (%d blocks) written" % (new_percentage, n))
            percentage[0] = new_percentage

    with rados.Rados(conffile=conffile) as r:
        with r.open_ioctx(pool) as ioctx:
            with rbd.Image(ioctx, image_name) as image:
                block_size = image.stripe_unit()
                pattern = 'A' * block_size
                block_count = image.size() / block_size
                print("writing %d blocks, size %d\r" % (block_count, block_size))

                for n in xrange(0, block_count):
                    image.write(pattern, n * block_size)
                    report_progress(n)


def main():
    if len(sys.argv) == 2:
        fill_image(sys.argv[1])
    else:
        print("Usage: %s <rbd_image>" % sys.argv[0])
        sys.exit(1)

if __name__ == '__main__':
    main()
