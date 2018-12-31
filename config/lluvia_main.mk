# LLuviaOS apps
PRODUCT_PACKAGES += \
     Blokada \
     MarkupGoogle \
     WellbeingPrebuilt \
     LatinIME \
     Launcher3 \
     WallpaperPickerGooglePrebuilt \
     WeatherClient \
     MaterialFXPrebuilt \
     AmbientPlayHistoryProvider

# QS tile styles
PRODUCT_PACKAGES += \
    QStilesSquare \
    QStilesRoundedSquare \
    QStilesSquircle \
    QStilesTearDrop \
    QStilesDroplet

# Cutout control overlays
PRODUCT_PACKAGES += \
    HideCutout \
    StatusBarStock

# Markup libs
ifeq ($(TARGET_ARCH),arm64)
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/lib/libsketchology_native.so:system/lib/libsketchology_native.so \
    vendor/lluvia/prebuilt/common/lib64/libsketchology_native.so:system/lib64/libsketchology_native.so

else
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/lib/libsketchology_native.so:system/lib/libsketchology_native.so
endif

# Pixel sysconfig
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/etc/sysconfig/pixel.xml:system/etc/sysconfig/pixel.xml \
    vendor/lluvia/prebuilt/common/etc/sysconfig/google-hiddenapi-package-whitelist.xml:system/etc/sysconfig/google-hiddenapi-package-whitelist.xml

# Fonts
include vendor/lluvia/config/fonts.mk

# LLuvia Theme
include vendor/lluvia/themes/config.mk

# LLuvia props
$(call inherit-product, vendor/lluvia/config/lluvia_props.mk)

# Call Overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/lluvia/themes/overlay/common

# Clean cache
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/bin/clean_cache.sh:system/bin/clean_cache.sh

# Weather
PRODUCT_COPY_FILES += \
     vendor/lluvia/prebuilt/common/etc/permissions/com.lluvia.weather.client.xml:system/etc/permissions/com.lluvia.weather.client.xml

# Wi-fi
PRODUCT_PROPERTY_OVERRIDES := \
     persist.sys.wfd.nohdcp=1 \
     persist.debug.wfd.enable=1 \
     persist.sys.wfd.virtual=0 \
     persist.debug.wfd.enable=1 \
     persist.sys.wfd.virtual=0

# Sounds
include vendor/lluvia/config/sounds.mk

# Telephony
PRODUCT_PACKAGES += \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

