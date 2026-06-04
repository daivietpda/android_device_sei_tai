#
# Copyright (C) 2021-2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#


PRODUCT_PACKAGES += \
    DopinderBluetoothOverlay \
    libbt-vendor

## GMS
ifeq ($(WITH_GMS),true)
GMS_MAKEFILE=gms_minimal.mk
endif
\
$(call soong_config_set,brcm_libbt,bdroid_buildcfg_include_dir,$(LOCAL_PATH)/bluetooth/include)
$(call soong_config_set,brcm_libbt,custom_bt_config,//$(LOCAL_PATH):vnd_tai.txt)

## Bluetooth firmware
include kernel/amlogic/kernel-modules/dhd-driver/firmware/bluetooth/bluetooth.mk

## Init-Files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init-files/init.amlogic.wifi_buildin.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.amlogic.wifi_buildin.rc \
    $(LOCAL_PATH)/init-files/init.amlogic.target.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.amlogic.target.rc \
    $(LOCAL_PATH)/init-files/init.recovery.tai.rc:recovery/root/init.recovery.tai.rc

## Keylayout (IR)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayout/Vendor_0001_Product_0001.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/Vendor_0001_Product_0001.kl \
    $(LOCAL_PATH)/keylayout/Vendor_7545_Product_017e.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/Vendor_7545_Product_017e.kl

## Netflix
PRODUCT_PACKAGES += \
    NetflixConfig \
    DopinderNetflixConfigOverlay

## Soong Namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/broadcom/libbt

## Wi-Fi firmware
include kernel/amlogic/kernel-modules/dhd-driver/firmware/wifi/wifi.mk

## GAPP TV
$(call inherit-product-if-exists, vendor/gapps_tv/arm/arm-vendor.mk)

## Inherit from the common tree product makefile
$(call inherit-product, device/amlogic/g12-common/g12.mk)

## Inherit from the proprietary files makefile
$(call inherit-product, vendor/sei/tai/tai-vendor.mk)
