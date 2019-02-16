# Copyright (C) 2018 LLuvia Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

PRODUCT_BRAND ?= LLuvia

LLUVIA_VERSION_NUMBER := v3.0

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
        Updates
	
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

ifneq ($(IS_GENERIC_SYSTEM_IMAGE), true)

ifeq ($(IS_GO_VERSION), true)
CUSTOM_OTA_VERSION_CODE := pie_go
else
CUSTOM_OTA_VERSION_CODE := pie
endif

PRODUCT_GENERIC_PROPERTIES += \
  ro.lluviaos.ota.version_code=$(CUSTOM_OTA_VERSION_CODE)

endif
