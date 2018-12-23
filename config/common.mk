PRODUCT_BRAND ?= LLuvia

LLUVIA_VERSION_NUMBER := Beta-v2.0

ifndef LLUVIA_BUILD_TYPE
LLUVIA_BUILD_TYPE := ManMade

PRODUCT_GENERIC_PROPERTIES += \
    ro.lluvia.buildtype=ManMade
endif

ifeq ($(LLUVIA_BUILD_TYPE), OFFICIAL)
    LIST = $(shell curl -s https://raw.githubusercontent.com/LLuviaOS/android_vendor_lluvia/3.0/lluvia.devices)
    FOUND_DEVICE =  $(filter $(CURRENT_DEVICE), $(LIST))
    ifeq ($(FOUND_DEVICE),$(CURRENT_DEVICE))
	LLUVIA_BUILD_TYPE := NatureMade
	PRODUCT_GENERIC_PROPERTIES += \
    		ro.lluvia.buildtype=NatureMade

PRODUCT_PACKAGES += \
    Updater

    endif
    ifneq ($(LLUVIA_BUILD_TYPE), NatureMade)
	LLUVIA_BUILD_TYPE := ManMade
        $(error Device is not official "$(FOUND)")
    endif
endif

LLUVIA_MOD_VERSION := Crystal
LLUVIA_VERSION := LLuviaOS-$(LLUVIA_VERSION_NUMBER)-$(LLUVIA_MOD_VERSION)-$(LLUVIA_BUILD)-$(LLUVIA_BUILD_TYPE)-$(shell date -u +%Y%m%d)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_PROPERTY_OVERRIDES += \
  ro.lluvia.version=$(LLUVIA_VERSION) \
  ro.lluvia.releasetype=$(LLUVIA_BUILD_TYPE) \
  ro.modversion=$(LLUVIA_MOD_VERSION)

LLUVIA_DISPLAY_VERSION := $(LLUVIA_VERSION)

PRODUCT_PROPERTY_OVERRIDES += \
  ro.lluvia.display.version=$(LLUVIA_DISPLAY_VERSION)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    sys.use_fifo_ui=1

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.build.selinux=1

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.dun.override=0
endif

ifeq ($(BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE),)
  PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.device.cache_dir=/data/cache
else
  PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.device.cache_dir=/cache
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/lluvia/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/lluvia/prebuilt/common/bin/50-lluvia.sh:system/addon.d/50-lluvia.sh \
    vendor/lluvia/prebuilt/common/bin/blacklist:system/addon.d/blacklist

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/lluvia/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/lluvia/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/lluvia/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# init.d support
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/bin/sysinit:system/bin/sysinit

# Copy all LLuviaOS-specific init rc files
$(foreach f,$(wildcard vendor/lluvia/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/lluvia/config/twrp.mk
endif

# Bootanimation
ifeq ($(TARGET_BOOT_ANIMATION_RES),360)
     PRODUCT_COPY_FILES += vendor/lluvia/media/360.zip:system/media/bootanimation.zip
else ifeq ($(TARGET_BOOT_ANIMATION_RES),720)
     PRODUCT_COPY_FILES += vendor/lluvia/media/720.zip:system/media/bootanimation.zip
else ifeq ($(TARGET_BOOT_ANIMATION_RES),1080)
     PRODUCT_COPY_FILES += vendor/lluvia/media/1080.zip:system/media/bootanimation.zip
else ifeq ($(TARGET_BOOT_ANIMATION_RES),1280)
     PRODUCT_COPY_FILES += vendor/lluvia/media/1280.zip:system/media/bootanimation.zip
else ifeq ($(TARGET_BOOT_ANIMATION_RES),1440)
     PRODUCT_COPY_FILES += vendor/lluvia/media/1440.zip:system/media/bootanimation.zip
else ifeq ($(TARGET_BOOT_ANIMATION_RES),1600)
     PRODUCT_COPY_FILES += vendor/lluvia/media/1600.zip:system/media/bootanimation.zip
else ifeq ($(TARGET_BOOT_ANIMATION_RES),2160)
     PRODUCT_COPY_FILES += vendor/lluvia/media/2160.zip:system/media/bootanimation.zip
else ifeq ($(TARGET_BOOT_ANIMATION_RES),2340)
     PRODUCT_COPY_FILES += vendor/lluvia/media/2340.zip:system/media/bootanimation.zip
else
    $(error "Bootanimation: TARGET_BOOT_ANIMATION_RES is undefined")
endif

# Fix Google dialer
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/etc/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Extra tools in LLuviaOS
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    fsck.ntfs \
    gdbserver \
    htop \
    lib7z \
    libsepol \
    micro_bench \
    mke2fs \
    mkfs.ntfs \
    mount.ntfs \
    oprofiled \
    pigz \
    powertop \
    sqlite3 \
    strace \
    tune2fs \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# exFAT tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    mkfs.exfat

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    procmem \
    procrank

# Substratum Key
PRODUCT_PACKAGES += \
    vendor/lluvia/prebuilt/common/apk/SubstratumKey.apk:system/priv-app/SubstratumKey/SubstratumKey.apk

# Conditionally build in su
ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su
endif
endif

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/lluvia/config/partner_gms.mk

include vendor/lluvia/config/lluvia_main.mk

$(call inherit-product-if-exists, vendor/extra/product.mk)
