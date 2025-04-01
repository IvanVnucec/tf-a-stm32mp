#!/bin/bash

set -x -e

UBOOT_BUILD_DIR=../u-boot-stm32mp/build-stm32mp157d-bsb
TFA_DTB=stm32mp157-somic
TFA_FLAGS="-j8 STM32MP_USB_PROGRAMMER=1 CROSS_COMPILE=arm-none-eabi- PLAT=stm32mp1 ARCH=aarch32 ARM_ARCH_MAJOR=7 DTB_FILE_NAME=$TFA_DTB.dtb"
# LOG_LEVEL=LOG_LEVEL_VERBOSE STM32MP_EARLY_CONSOLE=1

rm -rf build
make $TFA_FLAGS AARCH32_SP=sp_min bl32 dtbs
make $TFA_FLAGS
make $TFA_FLAGS AARCH32_SP=sp_min BL33=$UBOOT_BUILD_DIR/u-boot-nodtb.bin BL33_CFG=$UBOOT_BUILD_DIR/u-boot.dtb fip
