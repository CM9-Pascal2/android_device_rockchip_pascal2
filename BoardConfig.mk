#
# Copyright (C) 2011 The Android Open-Source Project
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
#

# This variable is set first, so it can be overridden
# by BoardConfigVendor.mk
USE_CAMERA_STUB := true

# Use the non-open-source parts, if they're present
-include vendor/rockchip/pascal2/BoardConfigVendor.mk

TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
ARCH_ARM_HAVE_TLS_REGISTER := true


#boot #TODO
BOARD_KERNEL_CMDLINE := console=ttyS1,115200n8n androidboot.console=ttyS1 init=/init initrd=0x62000000,0x800000 mtdparts=rk29xxnand:0x00002000@0x00002000(misc),0x00004000@0x00004000(kernel),0x00008000@0x00008000(boot),0x00008000@0x00010000(recovery),0x000F0000@0x00018000(backup),0x0003a000@0x00108000(cache),0x00200000@0x00142000(userdata),0x00002000@0x00342000(kpanic),0x000E6000@0x00344000(system),-@0x0042A000(user)
BOARD_KERNEL_BASE := 0x60400000
BOARD_KERNEL_PAGESIZE := 4096

TARGET_PROVIDES_INIT_RC := true

#BOARD_CUSTOM_BOOTIMG_MK := device/rockchip/pascal2/shbootimg.mk

# Partitions 
BOARD_BOOTIMAGE_PARTITION_SIZE := 9388608
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 9388608
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 339738624
BOARD_USERDATAIMAGE_PARTITION_SIZE := 2013200384
BOARD_FLASH_BLOCK_SIZE := 4096
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_HAS_LARGE_FILESYSTEM := true

TARGET_PREBUILT_KERNEL := device/rockchip/pascal2/kernel

#graphics
BOARD_EGL_CFG := device/rockchip/pascal2/egl.cfg
BOARD_NO_RGBX_8888 := true
#USE_OPENGL_RENDERER := true

BOARD_USE_LEGACY_TOUCHSCREEN := true

#recovery
TARGET_RECOVERY_INITRC := device/rockchip/pascal2/recovery_init.rc
BOARD_CUSTOM_RECOVERY_KEYMAPPING := ../../device/rockchip/pascal2/recovery_keys.c
BOARD_UMS_LUNFILE := "/sys/class/android_usb/android0/f_mass_storage/lun0/file"

#wlan
WPA_SUPPLICANT_VERSION := VER_0_6_X
BOARD_WPA_SUPPLICANT_DRIVER := WEXT
WIFI_DRIVER_MODULE_PATH     := "/system/lib/modules/wlan.ko"
WIFI_DRIVER_MODULE_ARG      := ""
WIFI_DRIVER_MODULE_NAME     := "wlan"


#Bluethoot
BOARD_HAVE_BLUETOOTH := false
#BOARD_HAVE_BLUETOOTH_BCM := true



