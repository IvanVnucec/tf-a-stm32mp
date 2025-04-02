#!/bin/bash

set -x -e

OPTEE_BUILD_DIR=../optee-stm32mp/build
UBOOT_BUILD_DIR=../u-boot-stm32mp/build
TFA_DTB=stm32mp157-somic.dtb
TFA_FLAGS="-j8 DEBUG=1 STM32MP_EARLY_CONSOLE=1 STM32MP_USB_PROGRAMMER=1 CROSS_COMPILE=arm-none-eabi- PLAT=stm32mp1 ARCH=aarch32 ARM_ARCH_MAJOR=7 DTB_FILE_NAME=$TFA_DTB"
# LOG_LEVEL=LOG_LEVEL_VERBOSE

rm -rf build
make $TFA_FLAGS AARCH32_SP=optee bl32 dtbs
make $TFA_FLAGS
make $TFA_FLAGS AARCH32_SP=optee \
    BL32=$OPTEE_BUILD_DIR/core/tee-header_v2.bin \
    BL32_EXTRA1=$OPTEE_BUILD_DIR/core/tee-pager_v2.bin \
    BL32_EXTRA2=$OPTEE_BUILD_DIR/core/tee-pageable_v2.bin \
    BL33=$UBOOT_BUILD_DIR/u-boot-nodtb.bin \
    BL33_CFG=$UBOOT_BUILD_DIR/u-boot.dtb \
    fip
