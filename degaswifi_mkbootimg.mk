# Define output targets
INSTALLED_RECOVERYIMAGE_TARGET := $(OUT)/recovery.img
INSTALLED_BOOTIMAGE_TARGET := $(OUT)/boot.img

# Recovery Image Target
$(INSTALLED_RECOVERYIMAGE_TARGET): device/samsung/degaswifi/mkbootimg \
		$(recovery_ramdisk) \
		$(recovery_kernel)
	@echo -e ${CL_CYN}"----- Making recovery image ------"${CL_RST}
	$(hide) device/samsung/degaswifi/mkbootimg $(INTERNAL_RECOVERYIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made recovery image: $@"${CL_RST}

# Boot Image Target
$(INSTALLED_BOOTIMAGE_TARGET): device/samsung/degaswifi/mkbootimg $(INTERNAL_BOOTIMAGE_FILES)
	$(call pretty,"Target boot image: $@")
	$(hide) device/samsung/degaswifi/mkbootimg $(INTERNAL_BOOTIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made boot image: $@"${CL_RST}

