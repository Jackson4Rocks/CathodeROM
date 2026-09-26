# Copyright (C) 2026 CathodeROM
# SPDX-License-Identifier: Apache-2.0

# Start from the Android generic x86_64 ABI. Kernel and bootloader integration
# will be supplied by the CathodeROM PC bring-up work instead of pretending
# that the generic AOSP target already boots physical laptops.
TARGET_CPU_ABI := x86_64
TARGET_ARCH := x86_64
TARGET_ARCH_VARIANT := x86_64

TARGET_2ND_CPU_ABI := x86
TARGET_2ND_ARCH := x86
TARGET_2ND_ARCH_VARIANT := x86_64

TARGET_BOARD_PLATFORM := cathode_x86_64

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_FLASH_BLOCK_SIZE := 512

# The first milestone is a userspace/device-tree build. These flags will be
# replaced as the UEFI/kernel image pipeline is brought up.
TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := true
