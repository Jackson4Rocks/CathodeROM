# Copyright (C) 2026 CathodeROM
# SPDX-License-Identifier: Apache-2.0
#
# Optional FOSS Google-services compatibility layer.
# This uses microG, not Google's proprietary GMS binaries.
# The vendor package provides GmsCore, GsfProxy, FakeStore and F-Droid.

$(call inherit-product-if-exists, vendor/partner_gms/products/gms.mk)
