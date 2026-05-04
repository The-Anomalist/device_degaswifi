#!/bin/sh
# Wrapper to adapt Oreo/Nougat mkbootimg flags to legacy PXA mkbootimg.
# - Strips unknown flags: --os_version, --os_patch_level, --id
# - Translates *_offset to *_addr if needed
set -e

OUT_ARGS=""
while [ $# -gt 0 ]; do
  case "$1" in
    --os_version|--os-patch-level|--os_patch_level|--id)
      if [ "$1" = "--os_version" ] || [ "$1" = "--os-patch-level" ] || [ "$1" = "--os_patch_level" ]; then
        shift
        [ $# -gt 0 ] && shift
      else
        shift
      fi
      ;;
    --kernel_offset)
      shift
      OUT_ARGS="$OUT_ARGS --kernel_addr $1"
      shift || true
      ;;
    --ramdisk_offset)
      shift
      OUT_ARGS="$OUT_ARGS --ramdisk_addr $1"
      shift || true
      ;;
    --tags_offset)
      shift
      OUT_ARGS="$OUT_ARGS --tags_addr $1"
      shift || true
      ;;
    --dt)
      shift
      OUT_ARGS="$OUT_ARGS --dt $1"
      shift || true
      ;;
    *)
      OUT_ARGS="$OUT_ARGS $1"
      shift
      ;;
  esac
done

exec "$ANDROID_BUILD_TOP/out/host/linux-x86/bin/pxa1088-mkbootimg" $OUT_ARGS
