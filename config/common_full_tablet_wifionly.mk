# Inherit common lluvia stuff
$(call inherit-product, vendor/lluvia/config/common.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include lluvia LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/lluvia/overlay/dictionaries
