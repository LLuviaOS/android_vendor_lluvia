# Copyright (C) 2016-2019 AOSIP
# Copyright (C) 2017-2020 LLuviaOS
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

# Versioning System
BUILD_DATE := $(shell date +%Y%m%d)
TARGET_PRODUCT_SHORT := $(subst lluvia_,,$(LLUVIA_BUILDTYPE))

LLUVIA_BUILDTYPE ?= ReBorn
LLUVIA_BUILD_VERSION := 10
LLUVIA_VERSION := $(LLUVIA_BUILD_VERSION)-$(LLUVIA_BUILDTYPE)-$(LLUVIA_BUILD)-$(BUILD_DATE)
ROM_FINGERPRINT := LLUVIA/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(shell date -u +%H%M)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.lluvia.build.version=$(LLUVIA_BUILD_VERSION) \
  ro.lluvia.build.date=$(BUILD_DATE) \
  ro.lluvia.buildtype=$(LLUVIA_BUILDTYPE) \
  ro.lluvia.fingerprint=$(ROM_FINGERPRINT) \
  ro.lluvia.version=$(LLUVIA_VERSION) \
  ro.lluvia.device=$(LLUVIA_BUILD) \
  ro.modversion=$(LLUVIA_VERSION)

ifneq ($(OVERRIDE_OTA_CHANNEL),)
    PRODUCT_PROPERTY_OVERRIDES += \
        lluvia.updater.uri=$(OVERRIDE_OTA_CHANNEL)
endif
