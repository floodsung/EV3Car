
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
//  EV3DirectCommander.h
//  EV3Wifi
//
//  Created by FloodSurge on 5/9/14.
//  Copyright (c) 2014 FloodSurge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EV3CommandDefinitions.h"
@interface EV3DirectCommander : NSObject

- (id)initWithCommandType:(EV3CommandType)commandType
               globalSize:(UInt16)globalSize
                localSize:(int)localSize;
- (NSData *)assembledCommandData;



#pragma mark - Motor Control Methods

+ (NSData *)turnMotorAtPort:(EV3OutputPort)port power:(int)power;

+ (NSData *)turnMotorsAtPort:(EV3OutputPort)port1 power:(int)power1 port:(EV3OutputPort)port2 power:(int)power2;

+ (NSData *)turnMotorAtPort:(EV3OutputPort)port power:(int)power degrees:(UInt32)degrees;

+ (NSData *)stopMotorAtPort:(EV3OutputPort)port;

#pragma mark - General Control Methods

+ (NSData *)clearAllCommands;

#pragma mark - Sound Control Methods

+ (NSData *)playToneWithVolume:(int)volume frequency:(UInt16)frequency duration:(UInt16)duration;

+ (NSData *)playSoundWithVolume:(int)volume filename:(NSString *)fileName repeat:(BOOL)repeat;

+ (NSData *)soundBrake;

#pragma mark - Image Control Methods

+ (NSData *)drawImageWithColor:(EV3ScreenColor)color x:(UInt16)x y:(UInt16)y fileName:(NSString *)fileName;

+ (NSData *)drawText:(NSString *)text color:(EV3ScreenColor)color x:(UInt16)x y:(UInt16)y;

+ (NSData *)drawFillWindowWithColor:(EV3ScreenColor)color y0:(UInt16)y0 y1:(UInt16)y1;

#pragma mark - Sensor Control Methods

+ (NSData *)scanPorts;

+ (NSData *)scanSensorTypeAndMode;

+ (NSData *)scanSensorData;

+ (NSData *)readSensorTypeAndModeAtPort:(EV3InputPort)port;

+ (NSData *)readSensorDataAtPort:(EV3InputPort)port mode:(int)mode;


@end
