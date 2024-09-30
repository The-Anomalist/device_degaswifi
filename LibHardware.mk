# Copyright (C) 2008 The Android Open Source Project
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

LOCAL_PATH := $(call my-dir)

# By default, ENABLE_HWC_GC_PATH should be false. Define ENABLE_HWC_GC_PATH as true in BoardConfig.mk to enable it.
ENABLE_HWC_GC_PATH ?= false

ifeq ($(ENABLE_HWC_GC_PATH), true)

# Static library: libHWComposerGC.a (Prebuilt)
include $(CLEAR_VARS)
LOCAL_MODULE := libHWComposerGC_prebuilt  # Name of the prebuilt library module
LOCAL_SRC_FILES := libHWComposerGC.a      # Path to your prebuilt static library file
LOCAL_MODULE_CLASS := STATIC_LIBRARIES
LOCAL_MODULE_SUFFIX := .a
LOCAL_MODULE_TAGS := optional
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)  # Export header file directories
LOCAL_MODULE_PATH := $(TARGET_OUT_INTERMEDIATES)  # Where to output

include $(BUILD_PREBUILT)

# Shared library: libHWComposerGC.so
include $(CLEAR_VARS)
LOCAL_MODULE := libHWComposerGC
LOCAL_SRC_FILES := HWCGCInterface.c  # Source file (ensure this file exists)
LOCAL_C_INCLUDES := \
    $(LOCAL_PATH) \
    hardware/libhardware/include  # Ensure this directory exists

LOCAL_SHARED_LIBRARIES := \
    libhardware \
    liblog \
    libutils \
    libcutils \
    libEGL \
    libbinder \
    libGAL \
    libsync

LOCAL_STATIC_LIBRARIES := libHWComposerGC_prebuilt  # Link with the prebuilt static library
LOCAL_CFLAGS := -DENABLE_HWC_GC_PATH -DINTEGRATED_WITH_MARVELL -g
LOCAL_MODULE_TAGS := optional
LOCAL_PRELINK_MODULE := false

include $(BUILD_SHARED_LIBRARY)

endif
