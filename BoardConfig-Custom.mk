LOCAL_PATH := $(call my-dir)

# Include hardware/marvell components
include hardware/marvell/MarvellWirelessDaemon/Android.mk
#include hardware/marvell/gpu-engine/Android.mk
#include hardware/marvell/graphics/Android.mk
#include hardware/marvell/hwcomposer/Android.mk
#include hardware/marvell/libhwcomposerGC/Android.mk
include hardware/marvell/libbt/Android.mk
#include hardware/marvell/libMarvellWireless/Android.mk
include hardware/marvell/wlan/Android.mk
#include hardware/marvell/marvell-gralloc/Android.mk
#include hardware/marvell/phycontmem-lib/Android.mk
#include hardware/marvell/sd8887/Android.mk
#include hardware/marvell/vmeta-lib/Android.mk

