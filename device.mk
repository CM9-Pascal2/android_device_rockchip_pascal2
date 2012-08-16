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

# Should be after the full_base include, which loads languages_full
PRODUCT_AAPT_CONFIG := normal tvdpi mdpi
PRODUCT_AAPT_PREF_CONFIG := mdpi

PRODUCT_LOCALES := en_US pt_PT es_ES
PRODUCT_CHARACTERISTICS := tablet

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/rockchip/pascal2/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

DEVICE_PACKAGE_OVERLAYS := device/rockchip/pascal2/overlay

#Ramdisk and boot
PRODUCT_COPY_FILES += \
	$(LOCAL_KERNEL):kernel.img \
    device/rockchip/pascal2/init.rc:root/init.rc \
	device/rockchip/pascal2/init.rk29board.usb.rc:root/init.rk29board.usb.rc \
	device/rockchip/pascal2/init.rk29board.rc:root/init.rk29board.rc \
    device/rockchip/pascal2/rk29xxnand_ko.ko.3.0.8+:root/rk29xxnand_ko.ko.3.0.8+ \
    device/rockchip/pascal2/rk29xxnand_ko.ko.3.0.8+:recovery/root/rk29xxnand_ko.ko.3.0.8+ \
	device/rockchip/pascal2/ueventd.rk29board.rc:root/ueventd.rk29board.rc \
	device/rockchip/pascal2/prebuilt/default.prop:recovery/root/default.prop \
	device/rockchip/pascal2/initlogo.rle:root/initlogo.rle \
    device/rockchip/pascal2/initlogo.rle:recovery/root/initlogo.rle \
	device/rockchip/pascal2/prebuilt/misc.img:recovery/root/misc.img \
    device/rockchip/pascal2/ueventd.rk29board.rc:recovery/root/ueventd.rk29board.rc
	
	
	
# These are the hardware-specific configuration files
PRODUCT_COPY_FILES += \
	device/rockchip/pascal2/etc/vold.fstab:system/etc/vold.fstab \
	device/rockchip/pascal2/etc/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf


#Rktools and custom boot/recovery img
PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,device/rockchip/pascal2/rktools,rktools) 

#Xbin
PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,device/rockchip/pascal2/prebuilt/xbin,system)
	
#usb
PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,device/rockchip/pascal2/prebuilt/usb,system) 

#Vendor firmware
#PRODUCT_COPY_FILES += \
#	$(call find-copy-subdir-files,*,device/rockchip/pascal2/prebuilt/vendor/firm,system/etc/firmware)

# Additional Scripts
PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,device/rockchip/pascal2/init.d,system/etc/init.d)

# Bluetooth configuration files
#PRODUCT_COPY_FILES += \
#	system/bluetooth/data/main.le.conf:system/etc/bluetooth/main.conf

# Propietary LIB and HW files
# device/rockchip/pascal2/prebuilt/lib/hw/sensors.rk29board.so:system/lib/hw/sensors.rk29board.so
#	device/rockchip/pascal2/prebuilt/lib/hw/camera.rk29board.so:system/lib/hw/camera.rk29board.so
#	device/rockchip/pascal2/prebuilt/lib/hw/audio.primary.rk29sdk.so:system/lib/hw/audio.primary.rk29sdk.so
#	device/rockchip/pascal2/prebuilt/lib/hw/audio_policy.rk29sdk.so:system/lib/hw/audio_policy.rk29sdk.so
#   device/rockchip/pascal2/prebuilt/lib/hw/hwcomposer.rk29board.so:system/lib/hw/hwcomposer.rk29board.so

PRODUCT_COPY_FILES += \
	device/rockchip/pascal2/prebuilt/lib/libril-rk29-dataonly.so:system/lib/libril-rk29-dataonly.so \
	device/rockchip/pascal2/prebuilt/lib/libRkDeflatingDecompressor.so:system/lib/libRkDeflatingDecompressor.so \
    device/rockchip/pascal2/prebuilt/lib/libGAL.so:system/lib/libGAL.so \
	device/rockchip/pascal2/prebuilt/lib/libGLSLC.so:system/lib/libGLSLC.so \
	device/rockchip/pascal2/prebuilt/lib/librkswscale.so:system/lib/librkswscale.so \
	device/rockchip/pascal2/prebuilt/lib/librkwmapro.so:system/lib/librkwmapro.so \
	device/rockchip/pascal2/prebuilt/lib/libyuvtorgb.so:system/lib/libyuvtorgb.so \
	device/rockchip/pascal2/prebuilt/lib/libvpu.so:system/lib/libvpu.so \
	device/rockchip/pascal2/prebuilt/lib/libjpeghwdec.so:system/lib/libjpeghwdec.so \
	device/rockchip/pascal2/prebuilt/lib/libjpeghwenc.so:system/lib/libjpeghwenc.so \
	device/rockchip/pascal2/prebuilt/lib/libwvm.so:system/lib/libwvm.so \
	device/rockchip/pascal2/prebuilt/lib/libWVStreamControlAPI_L1.so:system/lib/libWVStreamControlAPI_L1.so \
	device/rockchip/pascal2/egl.cfg:system/lib/egl/egl.cfg \
	device/rockchip/pascal2/prebuilt/lib/egl/libEGL_VIVANTE.so:system/lib/egl/libEGL_VIVANTE.so \
	device/rockchip/pascal2/prebuilt/lib/egl/libGLESv1_CM_VIVANTE.so:system/lib/egl/libGLESv1_CM_VIVANTE.so \
	device/rockchip/pascal2/prebuilt/lib/egl/libGLESv2_VIVANTE.so:system/lib/egl/libGLESv2_VIVANTE.so \
    device/rockchip/pascal2/prebuilt/lib/hw/copybit.rk29board.so:system/lib/hw/copybit.rk29board.so \
	device/rockchip/pascal2/prebuilt/lib/hw/gralloc.rk29board.so:system/lib/hw/gralloc.rk29board.so \
	device/rockchip/pascal2/prebuilt/lib/hw/camera.rk29board.so:system/lib/hw/vendor-camera.rk29board.so \
	device/rockchip/pascal2/prebuilt/lib/hw/lights.rk29board.so:system/lib/hw/lights.rk29board.so
	
#usr
PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,device/rockchip/pascal2/prebuilt/usr,system)
	
# Wifi
PRODUCT_PROPERTY_OVERRIDES := \
	wifi.interface=wlan0 \
	wifi.supplicant_scan_interval=15

# Media profiles
PRODUCT_COPY_FILES += \
    device/rockchip/pascal2/etc/media_codecs.xml:system/etc/media_codecs.xml \
    device/rockchip/pascal2/etc/media_profiles.xml:system/etc/media_profiles.xml
	
# Audio
PRODUCT_COPY_FILES += \
    device/rockchip/pascal2/etc/audio_policy.conf:system/etc/audio_policy.conf \
	device/rockchip/pascal2/etc/audio_effects.conf:system/etc/audio_effects.conf

PRODUCT_PACKAGES += \
	librs_jni \
	com.android.future.usb.accessory

# Filesystem management tools
PRODUCT_PACKAGES += \
   	utility_make_ext4fs \
	static_busybox \
	setup_fs \
	make_ext4fs \
	libstagefrighthw

	
#HAL port hardware
PRODUCT_PACKAGES += \
	libGLES_android_hw \
	camera.rk29board \
	sensors.rk29board \
	audio.primary.rk29board \
	audio_policy.default \
	tinyplay \
    	tinycap \
   	tinymix \
	audio.a2dp.default \
   	audio.usb.default \
   	libtinyalsa \
    	libaudioutils
	
	

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml


# for PDK build, include only when the dir exists
# too early to use $(TARGET_BUILD_PDK)
#ifneq ($(wildcard packages/wallpapers/LivePicker),)
PRODUCT_COPY_FILES += \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml
#endif	

#Build.prop 
PRODUCT_PROPERTY_OVERRIDES += \
	ro.sf.lcd_density=120 \
	ro.opengles.version=131072 \
	hwui.render_dirty_regions=false \
    	rild.libpath=/system/lib/libril-rk29-dataonly.so \
    	ro.kernel.android.checkjni=1 \
   	persist.sys.ui.hw=true \
    	opengl.vivante.texture=1 \
	ro.sf.fakerotation=true \
    	sys.hwc.compose_policy=6 \
	ro.vold.switchablepair=/mnt/sdcard,/mnt/external_sd \
	accelerometer.invert_x=1 \
	qemu.sf.lcd_density=120 \
	qemu.hw.mainkeys=0
	
PRODUCT_TAGS += dalvik.gc.type-precise
	
# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	persist.sys.usb.config=mass_storage	

# other kernel modules not in ramdisk
PRODUCT_COPY_FILES += $(foreach module,\
	$(filter-out $(RAMDISK_MODULES),$(wildcard device/rockchip/pascal2/modules/*.ko)),\
	$(module):system/lib/modules/$(notdir $(module)))

# copy the builder 
PRODUCT_COPY_FILES += \
	device/rockchip/pascal2/custom_boot.sh:custom_boot.sh

#Fix for dalvik-cache
PRODUCT_PROPERTY_OVERRIDES += \
	dalvik.vm.dexopt-data-only=1
	
#heap
include frameworks/native/build/tablet-7in-hdpi-1024-dalvik-heap.mk

#copy gapps to ROM
$(call inherit-product, device/rockchip/pascal2/gapps.mk)

$(call inherit-product-if-exists, vendor/rockchip/pascal2/device-vendor.mk)
