#
# Copyright (C) 2021-2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#


PRODUCT_PACKAGES += \
    DopinderBluetoothOverlay \
    libbt-vendor

## Factory
PRODUCT_HOST_PACKAGES += \
    aml_image_packer

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
    $(LOCAL_PATH)/idc/Vendor_7545_Product_0175.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/Vendor_7545_Product_0175.idc \
    $(LOCAL_PATH)/idc/Vendor_7545_Product_017e.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/Vendor_7545_Product_017e.idc \
    $(LOCAL_PATH)/keylayout/Vendor_0001_Product_0001.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/Vendor_0001_Product_0001.kl \
    $(LOCAL_PATH)/keylayout/Vendor_7545_Product_0175.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/Vendor_7545_Product_0175.kl \
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
G12_POWERHINT_CONFIG := $(LOCAL_PATH)/configs/powerhint.json
$(call inherit-product, device/amlogic/g12-common/g12.mk)

## Inherit from the proprietary files makefile
$(call inherit-product, vendor/sei/tai/tai-vendor.mk)

# Keep USB and network ADB enabled after a factory reset. ADB authentication is
# disabled through WITH_ADB_INSECURE in lineage_sei501.mk to avoid a duplicate
# ro.adb.secure assignment from Lineage common.mk.
PRODUCT_SYSTEM_PROPERTIES += \
    persist.sys.usb.config=adb \
    persist.adb.tcp.port=5555
