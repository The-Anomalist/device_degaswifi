# Custom boot image recipe for SM-T230NU (PXA1088 Samsung layout)

# Host tools
PXAMKBOOTIMG := $(HOST_OUT_EXECUTABLES)/pxa1088-mkbootimg
DTBTOOL      := $(HOST_OUT_EXECUTABLES)/pxa1088-dtbtool
WRAPPER      := device/samsung/degaswifi/tools/mkbootimg-wrapper.sh

# Standard AOSP outputs
PRODUCT_OUT := $(TARGET_OUT_INTERMEDIATES)/..
BOOTIMG     := $(PRODUCT_OUT)/boot.img
KERNEL_ZIMG := $(PRODUCT_OUT)/kernel
RAMDISK_IMG := $(PRODUCT_OUT)/ramdisk.img
DT_IMG      := $(PRODUCT_OUT)/dt.img

# Kernel DTB output directory. Some Oreo/Lineage custom boot rules include this
# file before KERNEL_OUT is exported, so use the stable product KERNEL_OBJ path.
DTB_DIR := $(PRODUCT_OUT)/obj/KERNEL_OBJ/arch/arm/boot/dts

# PXA1088 addresses & page size (match stock boot)
BASE           := 0x10000000
KERNEL_OFFSET  := 0x00008000
RAMDISK_OFFSET := 0x01000000
TAGS_OFFSET    := 0x00000100
PAGESIZE       := 2048

# Build PXA DT image from generated kernel DTBs.
# pxa1088-dtbtool expects an input directory, and its legacy path join logic
# requires the directory argument to include a trailing slash.
$(DT_IMG): $(KERNEL_ZIMG) $(DTBTOOL)
	@echo "PXA: bundling DTBs -> $@"
	@mkdir -p $(dir $@)
	@test -d $(DTB_DIR) || (echo "PXA: missing DTB dir: $(DTB_DIR)"; exit 1)
	$(hide) $(DTBTOOL) \
		-o $@ \
		-s $(PAGESIZE) \
		$(DTB_DIR)/
	$(hide) ls -lh $@

# Final boot image via wrapper (strips unsupported Oreo flags, keeps PXA args)
$(BOOTIMG): $(KERNEL_ZIMG) $(RAMDISK_IMG) $(DT_IMG) $(PXAMKBOOTIMG) $(WRAPPER)
	@echo "PXA: packing boot.img"
	@mkdir -p $(dir $@)
	$(hide) $(WRAPPER) \
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

# Ensure dt.img is in default installed set
ALL_DEFAULT_INSTALLED_MODULES += $(DT_IMG)
