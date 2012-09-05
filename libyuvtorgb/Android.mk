ifneq ($(filter pascal2 rk2918,$(TARGET_DEVICE)),)

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
   yuv420rgb8888c.c

LOCAL_MODULE := libyuvtorgb

LOCAL_MODULE_TAGS := optional
include $(BUILD_SHARED_LIBRARY)

endif

