# Copyright (C) 2026 JacksonTech
# SPDX-License-Identifier: Apache-2.0

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, device/cathoderom/laptop/lineage/device.mk)

WITH_GMS := true

PRODUCT_NAME := cathoderom_pc_x86_64
PRODUCT_DEVICE := laptop
PRODUCT_BRAND := CathodeOS
PRODUCT_MODEL := CathodeOS x86_64 PC
PRODUCT_MANUFACTURER := JacksonTech

PRODUCT_PACKAGES +=     adb
