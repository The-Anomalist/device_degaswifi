#!/bin/bash
# Wrapper to adapt Oreo mkbootimg flags to legacy PXA mkbootimg.
set -e

OUT_ARGS=()

while [ $# -gt 0 ]; do
  case "$1" in
    --os_version|--os-patch-level|--os_patch_level|--header_version)
      shift
      [ $# -gt 0 ] && shift
      ;;
    --id)
      shift
      ;;
    *)
      OUT_ARGS+=("$1")
      shift
      ;;
  esac
done

exec "$ANDROID_BUILD_TOP/out/host/linux-x86/bin/pxa1088-mkbootimg" "${OUT_ARGS[@]}"
