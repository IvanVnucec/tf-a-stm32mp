#!/bin/bash

set -x -e

TFA_DTB=stm32mp157a-somic
TFA_FLAGS="-j8 LOG_LEVEL=LOG_LEVEL_VERBOSE STM32MP_EARLY_CONSOLE=1 STM32MP_USB_PROGRAMMER=1 CROSS_COMPILE=arm-none-eabi- PLAT=stm32mp1 ARCH=aarch32 ARM_ARCH_MAJOR=7 DTB_FILE_NAME=$TFA_DTB.dtb"

rm -rf build
make $TFA_FLAGS AARCH32_SP=sp_min bl32 dtbs
make $TFA_FLAGS
make $TFA_FLAGS AARCH32_SP=sp_min BL33=../u-boot-stm32mp/build/u-boot-nodtb.bin BL33_CFG=../u-boot-stm32mp/build/u-boot.dtb fip
