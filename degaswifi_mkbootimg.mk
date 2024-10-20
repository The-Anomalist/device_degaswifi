# Define the build rules for boot and recovery images
# Note: Adjust the paths and variables as necessary

# Recovery Image Rule
$(INSTALLED_RECOVERYIMAGE_TARGET): device/samsung/degaswifi/prebuilts/mkbootimg \
		$(recovery_ramdisk) \
		$(recovery_kernel)
	@echo -e ${CL_CYN}"----- Making recovery image ------"${CL_RST}
	$(hide) device/samsung/degaswifi/prebuilts/mkbootimg $(INTERNAL_RECOVERYIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made recovery image: $@"${CL_RST}

# Boot Image Rule
$(INSTALLED_BOOTIMAGE_TARGET): device/samsung/degaswifi/prebuilts/mkbootimg $(INTERNAL_BOOTIMAGE_FILES)
	@echo -e ${CL_CYN}"----- Making boot image ------"${CL_RST}
	$(hide) device/samsung/degaswifi/prebuilts/mkbootimg $(INTERNAL_BOOTIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made boot image: $@"${CL_RST}

# Custom Boot Image Build Rule
bootimg: 
	@echo "Building boot.img for degaswifi..."
	$(LOCAL_PATH)/prebuilts/mkbootimg \
		--kernel $(OUT)/target/product/degaswifi/kernel \
		--ramdisk $(OUT)/target/product/degaswifi/ramdisk.img \
		--cmdline "initrd=0x01400000,12m rw uart_dma vmalloc=0x10000000 hwdfc=1 qhd_lcd=1 touch_type=0 androidboot.hardware=pxa1088 sec_debug.reset_reason=0x0 recovery_mode=1 ddr_mode=1 androidboot.emmc_checksum=3 androidboot.serialno=3004d96873b84100 lcd_id=0x005eb810 board_id=0x03 max_freq=1183 disp_start_addr=0x17000000 androidboot.debug_level=0x4f4c sec_debug.level=0 androidboot.lcd=WVGA sec_log=0x100000@0x8140000 cordon=87092f31480448a9f316c97caabd207b" \
		--base 0x10000000 \
		--ramdisk_offset 0x01000000 \
		--dt $(OUT)/target/product/degaswifi/boot.img-dt \
		--pagesize 2048 \
		--output $(OUT)/target/product/degaswifi/boot.img
	@echo "boot.img created successfully."

# This is used to ensure the 'bootimg' target runs during the overall build
.PHONY: bootimg

