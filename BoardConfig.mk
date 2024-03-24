# Copyright (C) 2013 The CyanogenMod Project
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

TARGET_SPECIFIC_HEADER_PATH := device/samsung/degaswifi/include

# Hacks
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_ENFORCE_SYSPROP_OWNER := true
BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE := true

# Target info
USE_CAMERA_STUB := true

# MRVL hardware
BOARD_USES_MRVL_HARDWARE := true
MRVL_ION := true

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a9
TARGET_BOARD_PLATFORM := mrvl
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true


# Kernel, bootloader, etc.
TARGET_KERNEL_SOURCE := kernel/samsung/degaswifi
TARGET_KERNEL_CONFIG := pxa1088_degaswifi_eur_defconfig

#kernel stuffs
BOARD_KERNEL_CMDLINE := initrd=0x01400000,12m rw uart_dma vmalloc=0x10000000 hwdfc=1 qhd_lcd=1 touch_type=0 androidboot.hardware=pxa1088 sec_debug.reset_reason=0x0 recovery_mode=1 ddr_mode=1 androidboot.emmc_checksum=3 androidboot.serialno=3004d96873b84100 lcd_id=0x005eb810 board_id=0x03 max_freq=1183 disp_start_addr=0x17000000 androidboot.debug_level=0x4f4c sec_debug.level=0 androidboot.lcd=WVGA sec_log=0x100000@0x8140000 cordon=87092f31480448a9f316c97caabd207b
BOARD_KERNEL_BASE := 0x10000000
BOARD_NAME :=
BOARD_PAGE_SIZE := 2048
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_SECOND_OFFSET := 0x00f00000
BOARD_TAGS_OFFSET := 0x00000100
BOARD_DT_SIZE := 534528
BOARD_UNKNOWN := 0x02000000
#BOARD_MKBOOTIMG_ARGS := --dt device/samsung/degaswifi/prebuilts/boot.img-dt 

TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# DTB
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
#BOARD_MKBOOTIMG_ARGS += --dtb device/samsung/degaswifi/prebuilts/dtb.img
BOARD_MKBOOTIMG_ARGS += --ramdisk device/samsung/degaswifi/prebuilts/ramdisk.img

# Assert
TARGET_OTA_ASSERT_DEVICE := degaswifi,degas,SM-T230,SM-T230NU

# Use file-based OTA zips
BLOCK_BASED_OTA := false

# Audio
BOARD_USES_ALSA_AUDIO := true

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/samsung/degaswifi/bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_MRVL := true
MRVL_WIRELESS_DAEMON_API := true

# Charging mode
BOARD_CHARGING_MODE_BOOTING_LPM := true

# Prebuilt webview
PRODUCT_PREBUILT_WEBVIEWCHROMIUM := yes

# CM Hardware
BOARD_HARDWARE_CLASS := device/samsung/degaswifi/aosphw

# Graphics
BOARD_USES_MRVL_HARDWARE := true
BOARD_HAVE_PIXEL_FORMAT_INFO := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
USE_OPENGL_RENDERER := true
ENABLE_HWC_GC_PATH := true

# Healthd
#BOARD_HAL_STATIC_LIBRARIES := libhealthd.mrvl
    
# Partitions
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 12582912
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 12582912
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2224029696
BOARD_USERDATAIMAGE_PARTITION_SIZE := 5230297088
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_UMS_LUNFILE := "/sys/class/android_usb/f_mass_storage/lun0/file"

# Recovery
TARGET_RECOVERY_FSTAB := device/samsung/degaswifi/rootdir/fstab.pxa1088
#TARGET_PLATFORM_DEVICE_BASE := /devices/soc.2/

# Vold
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/class/android_usb/f_mass_storage/lun%d/file"

# Legacy MMAP for pre-lollipop blobs
BOARD_USES_LEGACY_MMAP := true

# SELinux
BOARD_SEPOLICY_DIRS += \
    device/samsung/degaswifi/sepolicy
    
# SELinux_Custom
BOARD_SEPOLICY_DIRS += \
    device/samsung/degaswifi/sepolicy-custom 


# WiFi
BOARD_HAVE_MARVELL_WIFI := true
BOARD_WLAN_VENDOR := MRVL
WIFI_DRIVER_MODULE_PATH := "/system/lib/modules/sd8xxx.ko"
WIFI_DRIVER_MODULE_NAME	:= "sd8xxx"
WIFI_DRIVER_MODULE_ARG := "firmware_path=/system/etc/firmware/mrvl/sd8777_uapsta.bin cfg80211_wext=12 sta_name=wlan uap_name=wlan wfd_name=p2p fw_name=mrvl/sd8777_uapsta.bin"
WIFI_DRIVER_FW_PATH_PARAM := "/sys/module/sd8xxx/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA := "/system/etc/firmware/mrvl/sd8777_uapsta.bin"
WIFI_DRIVER_FW_PATH_AP := "/system/etc/firmware/mrvl/sd8777_uapsta.bin"
WIFI_DRIVER_FW_PATH_P2P := "/system/etc/firmware/mrvl/sd8777_uapsta.bin"
WIFI_SDIO_IF_DRIVER_MODULE_PATH := "/system/lib/modules/mlan.ko"
WIFI_SDIO_IF_DRIVER_MODULE_NAME := "mlan"
WIFI_SDIO_IF_DRIVER_MODULE_ARG := ""
MRVL_WIRELESS_DAEMON_API := true
