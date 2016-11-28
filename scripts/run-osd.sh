#!/bin/sh
set -e

if [ -z "$1" ]; then
	echo "OSD id is mandatory" >&2
	exit 1
fi

if [ `id -u` != '0' ]; then
	exec sudo $0 $@
fi

id="$1"

if [ ! -d "/var/lib/ceph/osd/ceph-${id}" ]; then
	echo "No data directory of osd.${id}" >&2
	exit 1
fi

set -x
drive=`mount | awk "/ceph-${id}\>/ { sub(\"1\$\", \"\", \\$1); print \\$1 }"`
echo "osd.${id} drive: ${drive}"
if [ -z "$drive" ]; then
	echo "Failed to find data drive of osd.${id}" >&2
	exit 1
fi

set -x
ulimit -n 1048576
ulimit -p 1048576
ulimit -c unlimited
systemctl stop ceph-osd@${id}.service && exec numactl \
	--membind block:${drive##/dev/} \
	--cpunodebind block:${drive##/dev/} -- \
		/usr/bin/ceph-osd -f --cluster ceph --id ${id} --setuser ceph --setgroup ceph
