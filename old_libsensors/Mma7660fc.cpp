/*
 * Copyright (C) 2008 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <fcntl.h>
#include <errno.h>
#include <math.h>
#include <poll.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/select.h>

#define LOG_NDEBUG 1
#define LOG_NDDEBUG 1

#include <cutils/log.h>

#include "Mma7660fc.h"

/*****************************************************************************/
//:TODO: g-sensor should be complied with the driver interface
Mma7660fc::Mma7660fc()
: SensorBase(MMA_DEVICE_NAME, MMA_DATA_NAME),
      mEnabled(0),
      mPendingMask(0),
      mInputReader(32)
{
    memset(mPendingEvents, 0, sizeof(mPendingEvents));

    mPendingEvents[Accelerometer].version = sizeof(sensors_event_t);
    mPendingEvents[Accelerometer].sensor = ID_A;
    mPendingEvents[Accelerometer].type = SENSOR_TYPE_ACCELEROMETER;
    mPendingEvents[Accelerometer].acceleration.status = SENSOR_STATUS_ACCURACY_HIGH;    

    /*mPendingEvents[Orientation  ].version = sizeof(sensors_event_t);
    mPendingEvents[Orientation  ].sensor = ID_O;
    mPendingEvents[Orientation  ].type = SENSOR_TYPE_ORIENTATION;
    mPendingEvents[Orientation  ].orientation.status = SENSOR_STATUS_ACCURACY_HIGH;*/

    for (int i=0 ; i<numSensors ; i++)
        mDelays[i] = 200000000; // 200 ms by default
        
    mEnabled |= (1<<Accelerometer);
    //mEnabled |= (1<<Orientation);    
    update_delay();
}

Mma7660fc::~Mma7660fc() {
}

int Mma7660fc::enable(int32_t handle, int en)
{    
	int what = -1;
    switch (handle) {
        case ID_A: what = Accelerometer; break;
        //case ID_O: what = Orientation;   break;
    }
 
    if (uint32_t(what) >= numSensors)
        return -EINVAL;
 
    int newState = en ? 1 : 0;
    int err = 0;
 
	ALOGD("Mma7660fc: enable()  newState : %d ", newState);
 
    if ((uint32_t(newState) << what) != (mEnabled & (1 << what)))
    {
        if (!mEnabled)
            open_device();
 
        int cmd;
        /*
		switch (what)
        {
            case Accelerometer: cmd = ECS_IOCTL_APP_SET_RATE;  break; // ECS_IOCTL_APP_SET_AFLAG
            case Orientation:   cmd = ECS_IOCTL_APP_SET_RATE;  break; // ECS_IOCTL_APP_SET_MFLAG           
        }
		*/
		
		if ( newState == 1 ) {
			cmd = ECS_IOCTL_START;
		} else {
			cmd = ECS_IOCTL_CLOSE;
		}
 
        short flags = newState;
 
        err = ioctl(dev_fd, cmd, &flags);
        err = err < 0 ? -errno : 0;
 
        ALOGE_IF(err, "Mma7660fc: ECS_IOCTL_APP_SET_XXX failed (%s)", strerror(-err));
 
        if (!err)
        {
            mEnabled &= ~(1 << what);
            mEnabled |= (uint32_t(flags) << what);
            err = update_delay();
        }
 
        if (!mEnabled)
            close_device();
    }
 
    return err;
}

int Mma7660fc::setDelay(int32_t handle, int64_t ns)
{
    int what = -1;
    switch (handle) {
        case ID_A: what = Accelerometer; break;
        //case ID_O: what = Orientation;   break;
    }

    if (uint32_t(what) >= numSensors)
        return -EINVAL;

    if (ns < 0)
        return -EINVAL;

    mDelays[what] = ns;
    return update_delay();

}

int Mma7660fc::update_delay()
{
    if (mEnabled) {
        uint64_t wanted = -1LLU;
        for (int i=0 ; i<numSensors ; i++) {
            if (mEnabled & (1<<i)) {
                uint64_t ns = mDelays[i];
                wanted = wanted < ns ? wanted : ns;
            }
        }
        short delay = int64_t(wanted) / 1000000;
        ALOGD("Mma7660fc: update_delay  %d",delay);        
		//if (ioctl(dev_fd, ECS_IOCTL_APP_SET_DELAY, &delay))
        //    return -errno;
    }
    return 0;
}

int Mma7660fc::readEvents(sensors_event_t* data, int count)
{
    if (count < 1)
        return -EINVAL;

    ssize_t n = mInputReader.fill(data_fd);
    if (n < 0)
        return n;

    int numEventReceived = 0;
    input_event const* event;

    while (count && mInputReader.readEvent(&event)) {
        int type = event->type;
        if (type == EV_ABS) {
            processEvent(event->code, event->value);
            mInputReader.next();
        } else if (type == EV_SYN) {
            int64_t time = timevalToNano(event->time);
            for (int j=0 ; count && mPendingMask && j<numSensors ; j++) {
                if (mPendingMask & (1<<j)) {
                    mPendingMask &= ~(1<<j);
                    mPendingEvents[j].timestamp = time;
                    if (mEnabled & (1<<j)) {
                        *data++ = mPendingEvents[j];
                        count--;
                        numEventReceived++;
                    }
                }
            }
            if (!mPendingMask) {
                mInputReader.next();
            }
        } else {
            ALOGE("Mma7660fc: unknown event (type=%d, code=%d)",
                    type, event->code);
            mInputReader.next();
        }
    }

    return numEventReceived;
}

void Mma7660fc::processEvent(int code, int value)
{
    switch (code) {
        case EVENT_TYPE_ACCEL_X:
            mPendingMask |= 1<<Accelerometer;
            mPendingEvents[Accelerometer].acceleration.x = value * CONVERT_A_X;
            ALOGD("Mma7660fc: mPendingEvents[Accelerometer].acceleration.x = %f",mPendingEvents[Accelerometer].acceleration.x);
            break;
        case EVENT_TYPE_ACCEL_Y:
            mPendingMask |= 1<<Accelerometer;
            mPendingEvents[Accelerometer].acceleration.y = value * CONVERT_A_Y;
            ALOGD("Mma7660fc: mPendingEvents[Accelerometer].acceleration.y = %f",mPendingEvents[Accelerometer].acceleration.y);
            break;
        case EVENT_TYPE_ACCEL_Z:
            mPendingMask |= 1<<Accelerometer;
            mPendingEvents[Accelerometer].acceleration.z = value * CONVERT_A_Z;
            ALOGD("Mma7660fc: mPendingEvents[Accelerometer].acceleration.z = %f",mPendingEvents[Accelerometer].acceleration.z);
            break;        
        
        /*case EVENT_TYPE_ORIENT_STATUS:
            mPendingMask |= 1<<Orientation;
            mPendingEvents[Orientation].orientation.status =
                    uint8_t(value & SENSOR_STATE_MASK);
            break;
		*/
    }
}
