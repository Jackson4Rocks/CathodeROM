# Copyright (C) 2026 CathodeROM
# SPDX-License-Identifier: Apache-2.0

$(call inherit-product, device/cathoderom/laptop/device.mk)

PRODUCT_NAME := cathoderom_x86_64
PRODUCT_DEVICE := cathode_x86_64
PRODUCT_BRAND := CathodeROM
PRODUCT_MODEL := CathodeROM x86_64 Laptop
PRODUCT_MANUFACTURER := CathodeROM

PRODUCT_PACKAGES += \\
    adb
