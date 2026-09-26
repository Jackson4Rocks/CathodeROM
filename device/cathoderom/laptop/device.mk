# Copyright (C) 2026 CathodeROM
# SPDX-License-Identifier: Apache-2.0

# Reuse AOSP's x86_64 userspace/device foundations while CathodeROM builds
# its own physical-PC kernel and boot pipeline.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/board/generic_x86_64/device.mk)

PRODUCT_DEVICE := cathode_x86_64

$(call inherit-product, vendor/cathoderom/microg/microg.mk)
