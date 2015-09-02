#
# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Overlays
DEVICE_PACKAGE_OVERLAYS += device/samsung/degaswifi/overlay

# Hardware permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml

PRODUCT_CHARACTERISTICS := tablet

# Enable higher-res drawables while keeping mdpi as primary source
PRODUCT_AAPT_CONFIG := large mdpi hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := mdpi
PRODUCT_LOCALES += mdpi

# Charger
PRODUCT_PACKAGES += \
    charger \
    charger_res_images

# Net
PRODUCT_PACKAGES += \
    libnetcmdiface

# IR
PRODUCT_PACKAGES += \
    consumerir.mrvl

# Wireless
PRODUCT_PACKAGES += \
    libMarvellWireless \
    MarvellWirelessDaemon

# Graphics
PRODUCT_PACKAGES += \
    libHWComposerGC 

# Ramdisk
PRODUCT_COPY_FILES += \
    device/samsung/degaswifi/rootdir/fstab.pxa1088:root/fstab.pxa1088 \
    device/samsung/degaswifi/rootdir/init_bsp.rc:root/init_bsp.rc \
    device/samsung/degaswifi/rootdir/init_bsp.pxa1088.rc:root/init_bsp.pxa1088.rc \
    device/samsung/degaswifi/rootdir/init.pxa1088.rc:root/init.pxa1088.rc \
    device/samsung/degaswifi/rootdir/init.pxa1088.sensor.rc:root/init.pxa1088.sensor.rc \
    device/samsung/degaswifi/rootdir/init.pxa1088.usb.rc:root/init.pxa1088.usb.rc \
    device/samsung/degaswifi/rootdir/init_bsp.pxa1088.tel.rc:root/init_bsp.pxa1088.tel.rc \
    device/samsung/degaswifi/rootdir/init.pxa1088.security.rc:root/init.pxa1088.security.rc \
    device/samsung/degaswifi/rootdir/init.pxa1088.tel.rc:root/init.pxa1088.tel.rc \
    device/samsung/degaswifi/rootdir/init.wifi.rc:root/init.wifi.rc \
    device/samsung/degaswifi/rootdir/ueventd.pxa1088.rc:root/ueventd.pxa1088.rc

# Misc
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory

# ART
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dex2oat-filter=interpret-only \
    dalvik.vm.image-dex2oat-filter=speed

$(call inherit-product, frameworks/native/build/tablet-7in-hdpi-1024-dalvik-heap.mk)
