# Copyright (C) 2014-2025 The-Anomalist
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
TARGET_SPECIFIC_HEADER_PATH += device/samsung/degaswifi/pxa-mkbootimg

# --- Build knobs / bring-up helpers ---
TARGET_NO_BOOTANIMATION := true

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



TARGET_KERNEL_SOURCE := kernel/samsung/degaswifi
TARGET_KERNEL_CONFIG := pxa1088_degaswifi_eur_defconfig

# Boot / mkbootimg (PXA1088)
BOARD_CUSTOM_BOOTIMG_MK := device/samsung/degaswifi/mkbootimg.mk
BOARD_KERNEL_BASE := 0x10000000
BOARD_PAGE_SIZE := 2048
BOARD_KERNEL_OFFSET := 0x00008000     # => 0x10008000
BOARD_RAMDISK_OFFSET := 0x01000000    # => 0x11000000
BOARD_SECOND_OFFSET := 0x00f00000     # => 0x10f00000
BOARD_TAGS_OFFSET := 0x00000100       # => 0x10000100
# Keep cmdline minimal; bootloader typically appends device-specific args
BOARD_KERNEL_CMDLINE := console=ttyS0,115200n8 androidboot.hardware=pxa1088

# No bootloader/radio images
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

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

# CM/Lineage/AOSP hardware class (custom)
BOARD_HARDWARE_CLASS := device/samsung/degaswifi/aosphw

# Graphics
BOARD_HAVE_PIXEL_FORMAT_INFO := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
USE_OPENGL_RENDERER := true
ENABLE_HWC_GC_PATH := true

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
# TARGET_PLATFORM_DEVICE_BASE := /devices/soc.2/

# Vold
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/class/android_usb/f_mass_storage/lun%d/file"

# Legacy MMAP for pre-lollipop blobs
BOARD_USES_LEGACY_MMAP := true

# SELinux
BOARD_SEPOLICY_DIRS += \
    device/samsung/degaswifi/sepolicy
# Keep only if it actually contains .te/context files
BOARD_SEPOLICY_DIRS += \
    device/samsung/degaswifi/sepolicy-custom
SELINUX_FC := device/samsung/degaswifi/sepolicy/file_contexts
SELINUX_IGNORE_NEVERALLOWS := true

# Wi-Fi (align with sd8887 kernel modules)
BOARD_HAVE_MARVELL_WIFI := true
BOARD_WLAN_VENDOR := MRVL
WIFI_DRIVER_MODULE_PATH := "/system/lib/modules/sd8xxx.ko"
WIFI_DRIVER_MODULE_NAME := "sd8xxx"
WIFI_DRIVER_MODULE_ARG := "firmware_path=/system/etc/firmware/mrvl/sd8887_uapsta.bin cfg80211_wext=12 sta_name=wlan uap_name=wlan wfd_name=p2p fw_name=mrvl/sd8887_uapsta.bin"
WIFI_DRIVER_FW_PATH_PARAM := "/sys/module/sd8xxx/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA := "/system/etc/firmware/mrvl/sd8887_uapsta.bin"
WIFI_DRIVER_FW_PATH_AP  := "/system/etc/firmware/mrvl/sd8887_uapsta.bin"
WIFI_DRIVER_FW_PATH_P2P := "/system/etc/firmware/mrvl/sd8887_uapsta.bin"
WIFI_SDIO_IF_DRIVER_MODULE_PATH := "/system/lib/modules/mlan.ko"
WIFI_SDIO_IF_DRIVER_MODULE_NAME := "mlan"
WIFI_SDIO_IF_DRIVER_MODULE_ARG := ""
MRVL_WIRELESS_DAEMON_API := true
