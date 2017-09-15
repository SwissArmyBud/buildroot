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
rm -rf ${TARGET_DIR}/boot
mkdir ${TARGET_DIR}/boot
grep -qE '^/dev/mmcblk0p1' ${TARGET_DIR}/etc/fstab || \
	echo '/dev/mmcblk0p1	/boot		vfat	defaults	0	0	0' >> ${TARGET_DIR}/etc/fstab
echo "/boot/uboot.env	0x0000	0x4000	0x4000" > ${TARGET_DIR}/etc/fw_env.config

# CHMOD the SystemV initializer
chmod +x ${TARGET_DIR}/etc/init.d/S30sysctl

# Copy the udev rule and script for writing SD events to a UNIX SOCKET
cp board/mbay/${BOARD_NAME}/80autousb.rules ${TARGET_DIR}/etc/udev/rules.d/80autousb.rules
cp board/mbay/${BOARD_NAME}/socketpinger.sh ${TARGET_DIR}/socketpinger.sh
