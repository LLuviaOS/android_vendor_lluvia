ifeq ($(LLUVIA_BUILD_TYPE), OFFICIAL)

LLUVIA_OTA_VERSION_CODE := 4.1

LLUVIA_PROPERTIES += \
    org.lluvia.ota.version_code=$(LLUVIA_OTA_VERSION_CODE) \
    sys.ota.disable_uncrypt=1

PRODUCT_PACKAGES += \
    Updates

PRODUCT_COPY_FILES += \
    vendor/lluvia/config/permissions/org.lluvia.ota.xml:system/etc/permissions/org.lluvia.ota.xml

endif
