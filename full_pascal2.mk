# Copyright (C) 2011 The Android Open Source Project
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

# Camera
PRODUCT_PACKAGES := \
	Camera

# Build characteristics setting 
PRODUCT_CHARACTERISTICS := tablet

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
# Inherit from pascal2 device
$(call inherit-product, device/rockchip/pascal2/device.mk)

# Set those variables here to overwrite the inherited values.
PRODUCT_NAME := full_pascal2
PRODUCT_DEVICE := pascal2
PRODUCT_BRAND := Rockchip
PRODUCT_MODEL := CM10 on pascal
