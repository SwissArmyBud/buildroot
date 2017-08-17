#!/bin/sh

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

# Copy over the 1st stage boot configuration, set GPU mem while enabling camera and uart
cp board/mbay/${BOARD_NAME}/config.txt ${BINARIES_DIR}/config.txt
echo "gpu_mem=256" >> ${BINARIES_DIR}/config.txt
echo "start_x=1" >> ${BINARIES_DIR}/config.txt
echo "enable_uart=1" >> ${BINARIES_DIR}/config.txt
cp board/mbay/${BOARD_NAME}/cmdline.txt ${BINARIES_DIR}/cmdline.txt

# If UBoot exists and has been built, move to binaries directory and enable as 2nd stage kernel
if [-e ${BUILD_DIR}/uboot-${UBOOT_VERSION}/u-boot.bin]
	echo "Found uboot binary, moving to output..."
	cp output/build/uboot-${UBOOT_VERSION}/u-boot.bin ${BINARIES_DIR}/
	echo "kernel=u-boot.bin" >> ${BINARIES_DIR}/config.txt
fi

# Add UBoot boot script to the binaries directory
if [ -e ${BUILD_DIR}/uboot-${UBOOT_VERSION}/boot.scr ]; then
	echo "Found uboot script, moving to output..."
	cp ${BUILD_DIR}/uboot-${UBOOT_VERSION}/boot.scr ${BINARIES_DIR}
fi

# Rename fresh linux kernel to expected value for pi
if [ -e ${BINARIES_DIR}/zImage ]; then
	echo "Found fresh linux binary, renaming for pi boot..."
	mv ${BINARIES_DIR}/zImage ${BINARIES_DIR}/kernel7.img
fi

# Copy needed files from rpi-firmware and clean out the rest
if [ -d ${BINARIES_DIR}/rpi-firmware ]; then
	rm -f ${BINARIES_DIR}/rpi-firmware/*.txt
	mv ${BINARIES_DIR}/rpi-firmware/* ${BINARIES_DIR}
	rm -rf ${BINARIES_DIR}/rpi-firmware
fi

# Clear the image building directory and rebuild the new binary system image
rm -rf "${GENIMAGE_TMP}"
genimage                           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

exit $?
