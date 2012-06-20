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

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/rockchip/pascal2/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif


DEVICE_PACKAGE_OVERLAYS := device/rockchip/pascal2/overlay

PRODUCT_PACKAGES := \
	audio.a2dp.default \
	libaudioutils 

PRODUCT_COPY_FILES := \
	$(LOCAL_KERNEL):kernel.img \
        device/rockchip/pascal2/init.rc:root/init.rc \
        device/rockchip/pascal2/init.rk29board.usb.rc:root/init.rk29board.usb.rc \
	device/rockchip/pascal2/init.rk29board.rc:root/init.rk29board.rc \
        device/rockchip/pascal2/rk29xxnand_ko.ko.3.0.8+:root/rk29xxnand_ko.ko.3.0.8+ \
        device/rockchip/pascal2/rk29xxnand_ko.ko.3.0.8+:recovery/root/rk29xxnand_ko.ko.3.0.8+ \
	device/rockchip/pascal2/ueventd.rk29board.rc:root/ueventd.rk29board.rc \
        device/rockchip/pascal2/initlogo.rle:root/initlogo.rle \
        device/rockchip/pascal2/initlogo.rle:recovery/root/initlogo.rle \
        device/rockchip/pascal2/ueventd.rk29board.rc:recovery/root/ueventd.rk29board.rc \
	device/rockchip/pascal2/etc/vold.fstab:system/etc/vold.fstab \
	device/rockchip/pascal2/etc/media_profiles.xml:system/etc/media_profiles.xml \
	device/rockchip/pascal2/etc/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
	#device/rockchip/pascal2/prebuilt/reboot-recovery.sh:system/bin/reboot-recovery.sh
     

#Vendor firms
PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,device/rockchip/pascal2/prebuilt/vendor/firm,system/etc/firmware)

# kernel modules for ramdisk
PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,device/rockchip/pascal2/prebuilt/vendor/modules,system/lib/modules)

# Additional Scripts
PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,device/rockchip/pascal2/init.d,system/etc/init.d)

# Bluetooth configuration files
#PRODUCT_COPY_FILES += \
#	system/bluetooth/data/main.le.conf:system/etc/bluetooth/main.conf


# Wifi
PRODUCT_PROPERTY_OVERRIDES := \
	wifi.interface=wlan0 \
	wifi.supplicant_scan_interval=15

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	persist.sys.usb.config=mtp,adb

# Live Wallpapers
#PRODUCT_PACKAGES += \
#	LiveWallpapers \
#	LiveWallpapersPicker \
#	VisualizationWallpapers \
#	librs_jni

#Camera
PRODUCT_PACKAGES += \
     camera.rk2918board

# Key maps
PRODUCT_COPY_FILES += \
	device/rockchip/pascal2/prebuilt/rk29-keypad.kl:system/usr/keylayout/rk29-keypad.kl \
	device/rockchip/pascal2/prebuilt/AVRCP.kl:system/usr/keylayout/AVRCP.kl \

# Propietary files
PRODUCT_COPY_FILES += \
	device/rockchip/pascal2/prebuilt/lib/libril-rk29-dataonly.so:system/lib/libril-rk29-dataonly.so \
	device/rockchip/pascal2/prebuilt/lib/libRkDeflatingDecompressor.so:system/lib/libRkDeflatingDecompressor.so \
        device/rockchip/pascal2/prebuilt/lib/libGAL.so:system/lib/libGAL.so \
	device/rockchip/pascal2/prebuilt/lib/librkswscale.so:system/lib/librkswscale.so \
	device/rockchip/pascal2/prebuilt/lib/librkwmapro.so:system/lib/librkwmapro.so \
	device/rockchip/pascal2/egl.cfg:system/lib/egl/egl.cfg \
	device/rockchip/pascal2/prebuilt/lib/egl/libEGL_VIVANTE.so:system/lib/egl/libEGL_VIVANTE.so \
	device/rockchip/pascal2/prebuilt/lib/egl/libGLESv1_CM_VIVANTE.so:system/lib/egl/libGLESv1_CM_VIVANTE.so \
	device/rockchip/pascal2/prebuilt/lib/egl/libGLESv2_VIVANTE.so:system/lib/egl/libGLESv2_VIVANTE.so \
	device/rockchip/pascal2/prebuilt/lib/hw/audio.primary.rk29sdk.so:system/lib/hw/audio.primary.rk29sdk.so \
	device/rockchip/pascal2/prebuilt/lib/hw/camera.rk29board.so:system/lib/hw/camera.rk29board.so \
        device/rockchip/pascal2/prebuilt/lib/hw/copybit.rk29board.so:system/lib/hw/copybit.rk29board.so \
	device/rockchip/pascal2/prebuilt/lib/hw/gralloc.rk29board.so:system/lib/hw/gralloc.rk29board.so \
	device/rockchip/pascal2/prebuilt/lib/hw/hwcomposer.rk29board.so:system/lib/hw/hwcomposer.rk29board.so \
	device/rockchip/pascal2/prebuilt/lib/hw/lights.rk29board.so:system/lib/hw/lights.rk29board.so \
	device/rockchip/pascal2/prebuilt/usr/keylayout/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_028e.kl \
	device/rockchip/pascal2/prebuilt/usr/keylayout/Vendor_046d_Product_c216.kl:system/usr/keylayout/Vendor_046d_Product_c216.kl \
	device/rockchip/pascal2/prebuilt/usr/keylayout/Vendor_046d_Product_c294.kl:system/usr/keylayout/Vendor_046d_Product_c294.kl \
	device/rockchip/pascal2/prebuilt/usr/keylayout/Vendor_046d_Product_c299.kl:system/usr/keylayout/Vendor_046d_Product_c299.kl \
	device/rockchip/pascal2/prebuilt/usr/keylayout/Vendor_046d_Product_c532.kl:system/usr/keylayout/Vendor_046d_Product_c532.kl \
	device/rockchip/pascal2/prebuilt/usr/keylayout/Vendor_054c_Product_0268.kl:system/usr/keylayout/Vendor_054c_Product_0268.kl \
	device/rockchip/pascal2/prebuilt/usr/keylayout/Vendor_05ac_Product_0239.kl:system/usr/keylayout/Vendor_05ac_Product_0239.kl \
	device/rockchip/pascal2/prebuilt/usr/keylayout/Vendor_22b8_Product_093d.kl:system/usr/keylayout/Vendor_22b8_Product_093d.kl \
	device/rockchip/pascal2/prebuilt/lib/hw/sensors.rk29board.so:system/lib/hw/sensors.rk29board.so

# These are the hardware-specific features
# Permissions
PRODUCT_COPY_FILES += \
	frameworks/base/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
	frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
	frameworks/base/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
	frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/base/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
	frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/base/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
	frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
	frameworks/base/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/base/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/base/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:/system/etc/permissions/android.software.live_wallpaper.xml \

PRODUCT_PROPERTY_OVERRIDES += \
	ro.opengles.version=131072 \
        wifi.interface=wlan0 \
	hwui.render_dirty_regions=false \
	qemu.sf.lcd_density=120 \
        rild.libpath=/system/lib/libril-rk29-dataonly.so \
        ro.kernel.android.checkjni=1 \
        persist.sys.ui.hw=true \
        opengl.vivante.texture=1 \
        sys.hwc.compose_policy=6 

PRODUCT_CHARACTERISTICS := tablet

PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_PACKAGES += \
	librs_jni \
	com.android.future.usb.accessory

# Filesystem management tools
PRODUCT_PACKAGES += \
	make_ext4fs \
	setup_fs

#Calibration app
PRODUCT_PACKAGES += \
       TSCalibration

#Fix for dalvik-cache
PRODUCT_PROPERTY_OVERRIDES += \
	dalvik.vm.dexopt-data-only=1

# Should be after the full_base include, which loads languages_full
PRODUCT_LOCALES += mdpi


$(call inherit-product, frameworks/base/build/tablet-dalvik-heap.mk)
$(call inherit-product-if-exists, vendor/rockchip/pascal2/device-vendor.mk)
