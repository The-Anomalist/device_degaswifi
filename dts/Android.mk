LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

# Specify the module class
LOCAL_MODULE_CLASS := PREBUILT
LOCAL_MODULE := dtb_images
LOCAL_SRC_FILES := \
    pxa1088-degaswifi-r01.dtb \
    pxa1088-degaswifi-r02.dtb \
    pxa1088-degaswifi-r03.dtb

# Specify the install path
LOCAL_MODULE_PATH := $(TARGET_OUT_PREBUILT)/dtb

include $(BUILD_PREBUILT)

