# Copyright (C) 2018-2019 LLuvia Open Source
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

#LLUVIA Versioning
LLUVIA_VERSION = v3.1

ifndef LLUVIA_BUILD_TYPE
    LLUVIA_BUILD_TYPE := UNOFFICIAL
endif

ifeq ($(LLUVIA_BUILD_TYPE), OFFICIAL)

# LLUVIAOTA
$(call inherit-product-if-exists, vendor/lluvia/config/ota.mk)

endif

TARGET_PRODUCT_SHORT := $(subst lluvia_,,$(CUSTOM_BUILD))

LLUVIA_BUILD_DATE := $(shell date -u +%Y%m%d-%H%M)
LLUVIA_MOD_VERSION := LLuviaOS-$(LLUVIA_VERSION)-$(LLUVIA_BUILD_DATE)-$(LLUVIA_BUILD_TYPE)
LLUVIA_FINGERPRINT := LLuviaOS/$(LLUVIA_VERSION)/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(LLUVIA_BUILD_DATE)

PRODUCT_GENERIC_PROPERTIES += \
  ro.lluvia.version=$(LLUVIA_VERSION) \
  ro.lluvia.releasetype=$(LLUVIA_BUILD_TYPE) \
  ro.modversion=$(LLUVIA_MOD_VERSION)

LLUVIA_DISPLAY_VERSION := LLuviaOS-$(LLUVIA_VERSION)-$(LLUVIA_BUILD_TYPE)

PRODUCT_GENERIC_PROPERTIES += \
  ro.lluvia.display.version=$(LLUVIA_DISPLAY_VERSION) \
  ro.lluvia.fingerprint=$(LLUVIA_FINGERPRINT)
