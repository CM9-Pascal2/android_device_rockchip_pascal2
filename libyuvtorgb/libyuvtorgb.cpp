/*
 * Copyright (C) 2012 Joaquim Pereira - joaquim.org
 *
 */

#define LOG_NDEBUG 0
#define LOG_TAG "libyuvtorgb"
#define FUNC_LOG ALOGV("+ > %s", __PRETTY_FUNCTION__)
//#define FUNC_LOG
 
#include <utils/Log.h>

// decode Y, U, and V values on the YUV 420 buffer described as YCbCr_422_SP by Android 
// David Manpearl 081201 
static int doYuvToRgb(int Y, int U, int V) {
	FUNC_LOG;
	return 0;
}