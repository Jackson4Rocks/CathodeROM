# Copyright (C) 2026 JacksonTech
# SPDX-License-Identifier: Apache-2.0

DEVICE_PATH := device/pc/basic_x86_64_pc

$(call inherit-product, device/pc/basic_x86_64_pc/device.mk)

PRODUCT_DEVICE := laptop

$(call inherit-product, device/cathoderom/laptop/vendor/cathoderom/microg/microg.mk)

PRODUCT_PACKAGE_OVERLAYS += device/cathoderom/laptop/overlay
