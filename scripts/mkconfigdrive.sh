#!/bin/sh
MYDIR="${0%/*}"
CONF_ISO="${1:-vm0-config.iso}"
CONF_DATA_DIR="$MYDIR/../config-drive"

exec genisoimage \
	-quiet \
	-input-charset utf-8 \
	-volid cidata \
	-joliet -rock \
	-output $CONF_ISO \
	"$CONF_DATA_DIR"
	

