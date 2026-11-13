#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common TWRP stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from T10 device
$(call inherit-product, device/along/T10/device.mk)

PRODUCT_DEVICE := T10
PRODUCT_NAME := twrp_T10
PRODUCT_BRAND := Vortex
PRODUCT_MODEL := T10M
PRODUCT_MANUFACTURER := along

PRODUCT_GMS_CLIENTID_BASE := android-along

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="full_tb8766p1_64_bsp-user 12 SP1A.210812.016 1689822961 release-keys"

BUILD_FINGERPRINT := Vortex/T10M/T10:12/SP1A.210812.016/1689822961:user/release-keys
