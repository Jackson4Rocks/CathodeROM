# Copyright (C) 2026 CathodeROM
# SPDX-License-Identifier: Apache-2.0

# CathodeOS keeps two PC bring-up profiles:
#   cathoderom_x86_64    - current AOSP/generic userspace profile
#   cathoderom_pc_x86_64 - LineageOS PC hardware/boot profile
ifeq ($(TARGET_PRODUCT),cathoderom_pc_x86_64)

include device/cathoderom/laptop/lineage/BoardConfig.mk

else

TARGET_CPU_ABI := x86_64
TARGET_ARCH := x86_64
TARGET_ARCH_VARIANT := x86_64

TARGET_2ND_CPU_ABI := x86
TARGET_2ND_ARCH := x86
TARGET_2ND_ARCH_VARIANT := x86_64

TARGET_BOARD_PLATFORM := cathode_x86_64

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_FLASH_BLOCK_SIZE := 512

TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := true

endif
