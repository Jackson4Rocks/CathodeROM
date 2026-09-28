# Copyright (C) 2026 CathodeROM
# SPDX-License-Identifier: Apache-2.0

PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/cathoderom_x86_64.mk \
    $(LOCAL_DIR)/cathoderom_pc_x86_64.mk

COMMON_LUNCH_CHOICES := \
    cathoderom_x86_64-trunk_staging-userdebug \
    cathoderom_pc_x86_64-trunk_staging-userdebug
