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
//  SRHitDetector.m
//  HeadHit
//
//  Created by Rotek on 3/7/13.
//  Copyright (c) 2013 Rotek. All rights reserved.
//

#import "SRMotionDetector.h"
#import <CoreMotion/CoreMotion.h>
#import "SRMath.h"

  
@interface SRMotionDetector ()
{
    double _degree;
}

@property (nonatomic,strong) CMMotionManager *motionManager;
@property (nonatomic,strong) NSTimer *timer;


@end

@implementation SRMotionDetector


+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    static SRMotionDetector *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Private Methods

- (id)init
{
    if (self = [super init]) {
        self.motionManager = [[CMMotionManager alloc] init];
        self.motionManager.deviceMotionUpdateInterval = 0.01f;
 
    }
    
    return self;
}

- (void)startUpdate
{
    NSLog(@"start update");
    if (self.motionManager.isDeviceMotionAvailable) {
        if (!self.motionManager.isDeviceMotionActive) {
            [self.motionManager startDeviceMotionUpdates];

            NSLog(@"Start device motion");
        }
    } else NSLog(@"Device motion unavailable");
    
}

- (void)stopUpdate
{
    NSLog(@"stopUpdate");
    if (self.motionManager.isDeviceMotionAvailable) {
        if (self.motionManager.isDeviceMotionActive) {
            [self.motionManager stopDeviceMotionUpdates];
            NSLog(@"Stop device motion");
        }
    } else NSLog(@"Device motion unavailable");
}


- (void)reset
{
    [self stopUpdate];
    [self startUpdate];
    
}

- (CGPoint)currentPoint
{
    return [self calculatePoint];
}



- (CGPoint)calculatePoint
{
    GLKQuaternion currentAttitude = GLKQuaternionMake(self.motionManager.deviceMotion.attitude.quaternion.x, self.motionManager.deviceMotion.attitude.quaternion.y, self.motionManager.deviceMotion.attitude.quaternion.z, self.motionManager.deviceMotion.attitude.quaternion.w);
    
    GLKVector3 initVector = GLKVector3Make(0, 10, 0);
    GLKVector3 currentVector = GLKQuaternionRotateVector3(currentAttitude, initVector);
    
    CGPoint point = CGPointMake(currentVector.x, currentVector.y);
    
    
    return point;
    
    
}

@end
