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


# Include vendor components
$(call inherit-product, hardware/marvell/graphics/Android.mk)
$(call inherit-product, hardware/marvell/gpu-engine/Android.mk)
$(call inherit-product, hardware/marvell/hwcomposer/Android.mk)
$(call inherit-product, hardware/marvell/hwcomposerGC/Android.mk)
$(call inherit-product, hardware/marvell/libbt/Android.mk)
$(call inherit-product, hardware/marvell/libMarvellWireless/Android.mk)
$(call inherit-product, hardware/marvell/marvell-gralloc/Android.mk)
#$(call inherit-product, hardware/marvell/MarvellWirelessDaemon/Android.mk)
$(call inherit-product, hardware/marvell/libstagefrighthw/Android.mk)
$(call inherit-product, hardware/marvell/phycontmem-lib/Android.mk)
$(call inherit-product, hardware/marvell/sd8787/Android.mk)

