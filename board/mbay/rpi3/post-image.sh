#!/bin/sh

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

cp board/jumpnow/${BOARD_NAME}/config.txt ${BINARIES_DIR}/config.txt
echo "start_x=1\nenable_uart=1" >> ${BINARIES_DIR}/config.txt
cp board/jumpnow/${BOARD_NAME}/cmdline.txt ${BINARIES_DIR}/cmdline.txt

if [-e ${BUILD_DIR}/uboot-${UBOOT_VERSION}/u-boot.bin]
	echo "Found uboot binary, moving to output..."
	cp output/build/uboot-${UBOOT_VERSION}/u-boot.bin ${BINARIES_DIR}/
fi

rm -rf "${GENIMAGE_TMP}"

genimage                           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

exit $?
