#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Not set in time to check, so set before everything else
PRODUCT_IS_ATV := true

# Inherit some common AOSP stuff
$(call inherit-product, device/google/atv/products/atv_base.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_tv.mk)

# Inherit device configuration
$(call inherit-product, $(LOCAL_PATH)/device.mk)

## Device identifier. This must come after all inclusions
PRODUCT_BRAND := Cellcomtv
PRODUCT_DEVICE := tai
PRODUCT_GMS_CLIENTID_BASE := android-sei-tv
PRODUCT_MANUFACTURER := sei
PRODUCT_MODEL := SEI-S905X2
PRODUCT_NAME := lineage_tai

PRODUCT_ATV_CLIENTID_BASE := ATV00100021

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="tai-user 12 SC 20240424 release-keys" \
    BuildFingerprint=Cellcomtv/SEI500CC/tai:12/SC/20240424:user/release-keys \
    DeviceName=tai \
    DeviceProduct=SEI500CC \
    SystemDevice=SEI500CC \
    SystemName=SEI500CC
