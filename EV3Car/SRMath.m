/****************************************************************************
 *
 * Copyright (c) 2015 Flood Surge. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 * 3. Neither the name PX4 nor the names of its contributors may be
 *    used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
 * OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
 * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 ****************************************************************************/
//
//  SRMath.m
//  3D Protractor
//
//  Created by Rotek on 12-12-25.
//  Copyright (c) 2012年 Rotek. All rights reserved.
//

#import "SRMath.h"

@implementation SRMath

+ (double)changePrecision:(int)precision WithNumber:(double)number
{
    /* example: number = 3.4684;
     * buffer1 = 3468;
     * buffer2 = 8 > 5;
     * buffer3 = 346 + 1 = 347;
     * buffer4 = 3.47;
     */
    double buffer0 = fabs(number);
    int buffer1 = (int)(buffer0 * pow(10, precision +1));
    int buffer2 = buffer1 % 10;
    int buffer3 = buffer1 / 10;

    
    if (buffer2 >= 5) {
        buffer3 += 1;
    }
    
    double buffer4 = (double)buffer3 / pow(10, precision);
    return number >= 0 ? buffer4 : buffer4 * -1;
    
    
}

+ (GLKQuaternion)GLKQuaternion:(GLKQuaternion)q1 rotateWithQuaternion:(GLKQuaternion)q2
{
    GLKQuaternion q;
    q.w = q1.w * q2.w - q1.x * q2.x - q1.y * q2.y - q1.z * q2.z;
    q.x = q1.w * q2.x + q1.x * q2.w + q1.y * q2.z - q1.z * q2.y;
    q.y = q1.w * q2.y + q1.y * q2.w + q1.z * q2.x - q1.x * q2.z;
    q.z = q1.w * q2.z + q1.z * q2.w + q1.x * q2.y - q1.y * q2.x;
    
    q = GLKQuaternionNormalize(q);
    return q;
    
}



+ (GLKQuaternion)createFromVector0:(GLKVector3)v0 vector1:(GLKVector3)v1
{
    GLKVector3 sum = GLKVector3Add(v0, v1);
    if ((sum.x == 0) && (sum.y == 0) && (sum.z == 0)) {
        return GLKQuaternionMakeWithAngleAndVector3Axis(M_PI, GLKVector3Make(1, 0, 0));
    }
    
    GLKVector3 c = GLKVector3CrossProduct(v0, v1);
    float d = GLKVector3DotProduct(v0, v1);
    float s = sqrtf((1+d)*2);
    
    return GLKQuaternionMake(c.x/s, c.y/s, c.z/s, s/2.0f);
}

@end
