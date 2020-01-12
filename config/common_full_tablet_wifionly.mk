# Inherit common lluvia stuff
$(call inherit-product, vendor/lluvia/config/common.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include LLuvia LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/overlay/dictionaries
