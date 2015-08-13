# Release name
PRODUCT_RELEASE_NAME := degaswifi

# Boot animation
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 800

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_tablet_wifionly.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/degaswifi/full_degaswifi.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := degaswifi
PRODUCT_NAME := cm_degaswifi
PRODUCT_BRAND := Samsung
PRODUCT_MODEL := SM-T230
PRODUCT_MANUFACTURER := samsung

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_FINGERPRINT=samsung/degaswifixx/degaswifi:4.4.2/KOT49H/T230XXU0AOD2:user/release-keys PRIVATE_BUILD_DESC="degaswifixx-user 4.4.2 KOT49H T230XXU0AOD2 release-keys"

