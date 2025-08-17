# Custom boot image recipe for SM-T230NU (PXA1088 Samsung layout)

# Host tools (built by Android.mk above)
MKBOOTIMG := $(HOST_OUT_EXECUTABLES)/mkbootimg
DTBTOOL   := $(HOST_OUT_EXECUTABLES)/pxa1088-dtbtool
WRAPPER   := device/samsung/degaswifi/tools/mkbootimg-wrapper.sh

# Standard AOSP outputs
PRODUCT_OUT := $(TARGET_OUT_INTERMEDIATES)/..
BOOTIMG     := $(PRODUCT_OUT)/boot.img
KERNEL_ZIMG := $(PRODUCT_OUT)/kernel
RAMDISK_IMG := $(PRODUCT_OUT)/ramdisk.img

# Kernel DTBs location (adjust if yours differs)
DTB_DIR  := kernel/samsung/degaswifi/arch/arm/boot/dts
DTB_LIST := $(wildcard $(DTB_DIR)/*.dtb)
DT_IMG   := $(PRODUCT_OUT)/dt.img

# Build PXA DT image from all DTBs
$(DT_IMG): $(DTB_LIST) $(DTBTOOL)
	@echo "PXA: bundling DTBs -> $@"
	@mkdir -p $(dir $@)
	$(DTBTOOL) -o $@ $(DTB_LIST)

# PXA1088 addresses & page size (match stock boot)
BASE           := 0x10000000
KERNEL_OFFSET  := 0x00008000     # => 0x10008000
RAMDISK_OFFSET := 0x01000000     # => 0x11000000
TAGS_OFFSET    := 0x00000100     # => 0x10000100
PAGESIZE       := 2048

# Final boot image via wrapper (strips Nougat-only flags, adds PXA args)
$(BOOTIMG): $(KERNEL_ZIMG) $(RAMDISK_IMG) $(DT_IMG) $(MKBOOTIMG) $(WRAPPER)
	@echo "PXA: packing boot.img"
	@mkdir -p $(dir $@)
	$(WRAPPER) \
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
