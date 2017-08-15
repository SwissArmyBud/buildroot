#!/bin/sh

set -u
set -e

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

# Add automount option for u-boot utils to work on
mkdir ${TARGET_DIR}/boot
grep -qE '^/dev/mmcblk0p1' ${TARGET_DIR}/etc/fstab || \
	sed -i '/dev/mmcblk0p1	/boot	defaults	0	0	0' ${TARGET_DIR}/etc/fstab
	
echo "/boot/uboot.env	0x0000	0x4000	0x4000" > ${TARGET_DIR}/etc/fw_env.config