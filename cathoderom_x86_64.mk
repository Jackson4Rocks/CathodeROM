# Copyright (C) 2026 CathodeROM
# SPDX-License-Identifier: Apache-2.0

$(call inherit-product, device/cathoderom/laptop/device.mk)

# Enable the FOSS microG integration supplied by vendor/partner_gms.
WITH_GMS := true

PRODUCT_NAME := cathoderom_x86_64
PRODUCT_DEVICE := cathode_x86_64
PRODUCT_BRAND := CathodeOS
PRODUCT_MODEL := CathodeOS x86_64 Laptop
PRODUCT_MANUFACTURER := CathodeOS

PRODUCT_PACKAGES += \
    adb
