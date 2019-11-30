LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_USES_AOSP_APNS_CONF),)
################################
# Copies the APN list file into system/etc for the product as apns-conf.xml.
# In the case where $(LLUVIA_APNS_FILE) is defined, the content of $(LLUVIA_APNS_FILE)
# is added or replaced to the $(DEFAULT_APNS_FILE).
include $(CLEAR_VARS)

LOCAL_MODULE := apns-conf.xml
LOCAL_MODULE_CLASS := ETC

DEFAULT_APNS_FILE := vendor/lluvia/prebuilt/common/etc/apns-conf.xml

ifdef LLUVIA_APNS_FILE
LLUVIA_APNS_SCRIPT := vendor/lluvia/tools/lluvia_apns.py
FINAL_APNS_FILE := $(local-generated-sources-dir)/apns-conf.xml

$(FINAL_APNS_FILE): PRIVATE_SCRIPT := $(LLUVIA_APNS_SCRIPT)
$(FINAL_APNS_FILE): PRIVATE_LLUVIA_APNS_FILE := $(LLUVIA_APNS_FILE)
$(FINAL_APNS_FILE): $(LLUVIA_APNS_SCRIPT) $(DEFAULT_APNS_FILE)
	rm -f $@
	python $(PRIVATE_SCRIPT) $@ $(PRIVATE_LLUVIA_APNS_FILE)
else
FINAL_APNS_FILE := $(DEFAULT_APNS_FILE)
endif

LOCAL_PREBUILT_MODULE_FILE := $(FINAL_APNS_FILE)

include $(BUILD_PREBUILT)
endif