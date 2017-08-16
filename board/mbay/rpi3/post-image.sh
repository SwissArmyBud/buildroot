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

# If Linux has been freshly built, ensure the kernel is appropriately named for 2nd or 3rd stage boot
if [-e ${BINARIES_DIR}/zImage]
	echo "Found raw kernel binary, renaming in output..."
	mv ${BINARIES_DIR}/zImage ${BINARIES_DIR}/kernel7.img
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
