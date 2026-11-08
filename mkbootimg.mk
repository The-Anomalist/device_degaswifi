# Custom boot image recipe for SM-T230NU (PXA1088 Samsung layout)

# Host tools built by hardware/marvell/pxa1088-mkbootimg/Android.mk
MKBOOTIMG := $(HOST_OUT_EXECUTABLES)/pxa1088-mkbootimg
DTBTOOL   := $(HOST_OUT_EXECUTABLES)/pxa1088-dtbTool

# Standard AOSP outputs
PRODUCT_OUT := $(TARGET_OUT_INTERMEDIATES)/..
BOOTIMG     := $(PRODUCT_OUT)/boot.img
KERNEL_ZIMG := $(PRODUCT_OUT)/kernel
RAMDISK_IMG := $(PRODUCT_OUT)/ramdisk.img

# DTBs are generated in the kernel output tree, not the source tree.
KERNEL_BUILD_OUT := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ
DTB_DIR  := $(KERNEL_BUILD_OUT)/arch/arm/boot/dts/
DT_IMG   := $(PRODUCT_OUT)/dt.img

# Build PXA DT image from all DTBs
$(DT_IMG): $(INSTALLED_KERNEL_TARGET) $(DTBTOOL)
	@echo "PXA: bundling DTBs -> $@"
	@mkdir -p $(dir $@)
	$(DTBTOOL) -o $@ -s $(PAGESIZE) -p $(KERNEL_BUILD_OUT)/scripts/dtc/ $(DTB_DIR)

# PXA1088 addresses & page size (match stock boot)
BASE           := 0x10000000
KERNEL_OFFSET  := 0x00008000     # => 0x10008000
RAMDISK_OFFSET := 0x01000000     # => 0x11000000
TAGS_OFFSET    := 0x00000100     # => 0x10000100
PAGESIZE       := 2048

# Final image uses the PXA1088-specific Samsung boot header.
$(BOOTIMG): $(KERNEL_ZIMG) $(RAMDISK_IMG) $(DT_IMG) $(MKBOOTIMG)
	@echo "PXA: packing boot.img"
	@mkdir -p $(dir $@)
	$(MKBOOTIMG) \
	  --kernel $(KERNEL_ZIMG) \
	  --ramdisk $(RAMDISK_IMG) \
	  --base $(BASE) \
	  --pagesize $(PAGESIZE) \
	  --kernel_offset $(KERNEL_OFFSET) \
	  --ramdisk_offset $(RAMDISK_OFFSET) \
	  --tags_offset $(TAGS_OFFSET) \
	  --dt $(DT_IMG) \
	  --cmdline "$(BOARD_KERNEL_CMDLINE)" \
	  --output $@
	@echo "PXA: wrote $@"

# BOARD_CUSTOM_BOOTIMG_MK disables the default recovery image rule, so pack
# the generated recovery ramdisk with the same Samsung PXA1088 header.
$(INSTALLED_RECOVERYIMAGE_TARGET): $(recovery_kernel) $(recovery_ramdisk) $(DT_IMG) $(MKBOOTIMG)
	@echo "PXA: packing recovery.img"
	@mkdir -p $(dir $@)
	$(MKBOOTIMG) \
	  --kernel $(recovery_kernel) \
	  --ramdisk $(recovery_ramdisk) \
	  --base $(BASE) \
	  --pagesize $(PAGESIZE) \
	  --kernel_offset $(KERNEL_OFFSET) \
	  --ramdisk_offset $(RAMDISK_OFFSET) \
	  --tags_offset $(TAGS_OFFSET) \
	  --dt $(DT_IMG) \
	  --cmdline "$(BOARD_KERNEL_CMDLINE)" \
	  --output $@
	@echo "PXA: wrote $@"

# Ensure dt.img is in default installed set
ALL_DEFAULT_INSTALLED_MODULES += $(DT_IMG)
