# Copyright (C) 2026 CathodeROM
# SPDX-License-Identifier: Apache-2.0

PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/cathoderom_x86_64.mk

COMMON_LUNCH_CHOICES := \
    cathoderom_x86_64-trunk_staging-userdebug

# The LineageOS PC profile is exposed only when its external device tree has
# been synced into the source checkout.
ifneq ($(wildcard $(TOPDIR)device/pc/basic_x86_64_pc/AndroidProducts.mk),)
PRODUCT_MAKEFILES += \
    $(LOCAL_DIR)/cathoderom_pc_x86_64.mk

COMMON_LUNCH_CHOICES += \
    cathoderom_pc_x86_64-trunk_staging-userdebug
endif
