/* Copyright (C) 2010 0xlab.org
 * Authored by: Kan-Ru Chen <kanru@0xlab.org>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.zeroxlab.util.tscal;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.view.MotionEvent;
import android.view.View;

import android.util.Log;

public class TSCalibrationView extends View {

    final private static String TAG = "TSCalibration";

    private class TargetPoint {
        public int x;
        public int y;
        public float calx;
        public float caly;
        public TargetPoint(int x, int y) {
            this.x = x;
            this.y = y;
        }
    }

    private int mStep = 0;
    private TargetPoint mTargetPoints[];
    private TSCalibration mContext;

    public TSCalibrationView(TSCalibration context, int h, int w) {
        super(context);

        mContext = context;
        mTargetPoints = new TargetPoint[5];
        mTargetPoints[0] = new TargetPoint(50, 50);
        mTargetPoints[1] = new TargetPoint(w - 50, 50);
        mTargetPoints[2] = new TargetPoint(w - 50, h - 50);
        mTargetPoints[3] = new TargetPoint(50, h - 50);
        mTargetPoints[4] = new TargetPoint(w/2, h/2);
    }

    public void reset() {
        mStep = 0;
    }

    public boolean isFinished() {
        return mStep >= 5;
    }

    public void dumpCalData(File file) {
        float x, y, x2, y2, xy, z, zx, zy;
        float det, a, b, c, e, f, i;
        int[] vals = new int[7];

        x = 0.0f;
        y = 0.0f;
        x2 = 0.0f;
        y2 = 0.0f;
        xy = 0.0f;
        for (TargetPoint point : mTargetPoints) {
            x += point.calx;
            y += point.caly;
            x2 += point.calx * point.calx;
            y2 += point.caly * point.caly;
            xy += point.calx * point.caly;
        }

        det = 5.0f * (x2 * y2 - xy * xy) + x * (xy * y - x * y2) + y * (x * xy - y * x2);
        a = (x2 * y2 - xy * xy) / det;
        b = (xy * y - x * y2) / det;
        c = (x * xy - y * x2) / det;
        e = (5.0f * y2 - y * y) / det;
        f = (x * y - 5.0f * xy) / det;
        i = (5.0f * x2 - x * x) / det;

        z = 0.0f;
        zx = 0.0f;
        zy = 0.0f;
        for (TargetPoint point : mTargetPoints) {
            z += (float)point.x;
            zx += (float)point.x * point.calx;
            zy += (float)point.x * point.caly;
        }
        vals[2] = (int)((a * z + b * zx + c * zy) * 65536.0f);
        vals[0] = (int)((b * z + e * zx + f * zy) * 65536.0f);
        vals[1] = (int)((c * z + f * zx + i * zy) * 65536.0f);

        z = 0.0f;
        zx = 0.0f;
        zy = 0.0f;
        for (TargetPoint point : mTargetPoints) {
            z += (float)point.y;
            zx += (float)point.y * point.calx;
            zy += (float)point.y * point.caly;
        }
        vals[5] = (int)((a * z + b * zx + c * zy) * 65536.0f);
        vals[3] = (int)((b * z + e * zx + f * zy) * 65536.0f);
        vals[4] = (int)((c * z + f * zx + i * zy) * 65536.0f);

        vals[6] = 65536;

        StringBuilder sb = new StringBuilder();
        for (int val : vals) {
            sb.append(val);
            sb.append(" ");
        }
        try {
            FileOutputStream fos = new FileOutputStream(file);
            fos.write(sb.toString().getBytes());
            fos.flush();
            fos.getFD().sync();
            fos.close();
        } catch (FileNotFoundException ex) {
            Log.e(TAG, "Cannot open file " + file);
        } catch (IOException ex) {
            Log.e(TAG, "Cannot write file " + file);
        }
    }

    @Override
    public boolean onTouchEvent(MotionEvent ev) {
        if (isFinished())
            return true;
        if (ev.getAction() != MotionEvent.ACTION_UP)
            return true;
        mTargetPoints[mStep].calx = ev.getRawX() * ev.getXPrecision();
        mTargetPoints[mStep].caly = ev.getRawY() * ev.getYPrecision();
        mStep++;
        mContext.onCalTouchEvent(ev);
        return true;
    }

    @Override
    protected void onDraw(Canvas canvas) {
        if (isFinished())
            return;
        canvas.drawColor(Color.BLACK);
        drawTarget(canvas, mTargetPoints[mStep].x, mTargetPoints[mStep].y);
    }

    private void drawTarget(Canvas c, int x, int y) {
        Paint white = new Paint(Paint.ANTI_ALIAS_FLAG);
        Paint red = new Paint(Paint.ANTI_ALIAS_FLAG);
        white.setColor(Color.WHITE);
        red.setColor(Color.RED);
        c.drawCircle(x, y, 25, red);
        c.drawCircle(x, y, 21, white);
        c.drawCircle(x, y, 17, red);
        c.drawCircle(x, y, 13, white);
        c.drawCircle(x, y, 9, red);
        c.drawCircle(x, y, 5, white);
        c.drawCircle(x, y, 1, red);
    }
}
