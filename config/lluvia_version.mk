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
endif

ifeq ($(LLUVIA_BUILD_TYPE), OFFICIAL)

# LLuviaOTA
$(call inherit-product-if-exists, vendor/lluvia/config/ota.mk)

endif

LLUVIA_MOD_VERSION := Crystal
LLUVIA_VERSION := LLuviaOS-$(LLUVIA_VERSION_NUMBER)-$(LLUVIA_MOD_VERSION)-$(LLUVIA_BUILD)-$(LLUVIA_BUILD_TYPE)-$(shell date -u +%Y%m%d)
LLUVIA_DATE_YEAR := $(shell date -u +%Y)
LLUVIA_DATE_MONTH := $(shell date -u +%m)
LLUVIA_DATE_DAY := $(shell date -u +%d)
LLUVIA_DATE_HOUR := $(shell date -u +%H)
LLUVIA_DATE_MINUTE := $(shell date -u +%M)
LLUVIA_BUILD_DATE_UTC := $(shell date -d '$(LLUVIA_DATE_YEAR)-$(LLUVIA_DATE_MONTH)-$(LLUVIA_DATE_DAY) $(LLUVIA_DATE_HOUR):$(LLUVIA_DATE_MINUTE) UTC' +%s)
LLUVIA_BUILD_DATE := $(LLUVIA_DATE_YEAR)$(LLUVIA_DATE_MONTH)$(LLUVIA_DATE_DAY)-$(LLUVIA_DATE_HOUR)$(LLUVIA_DATE_MINUTE)
LLUVIA_FINGERPRINT := LLuviaOS/$(LLUVIA_VERSION_NUMBER)/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(LLUVIA_BUILD_DATE)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_PROPERTY_OVERRIDES += \
  ro.lluvia.buildtype=$(LLUVIA_BUILD_TYPE) \
  ro.lluvia.version=$(LLUVIA_VERSION) \
  ro.lluvia.releasetype=$(LLUVIA_BUILD_TYPE) \
  ro.modversion=$(LLUVIA_MOD_VERSION)

LLUVIA_DISPLAY_VERSION := $(LLUVIA_VERSION)

PRODUCT_PROPERTY_OVERRIDES += \
  ro.lluvia.display.version=$(LLUVIA_DISPLAY_VERSION)
  ro.lluvia.fingerprint=$(LLUVIA_FINGERPRINT) \
  ro.lluvia.build_date_utc=$(LLUVIA_BUILD_DATE_UTC)
