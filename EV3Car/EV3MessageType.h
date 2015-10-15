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
//  EV3MessageType.h
//  Ev3WifiFit
//
//  Created by FloodSurge on 5/19/14.
//  Copyright (c) 2014 FloodSurge. All rights reserved.
//
//  Description: this head file is to define the message type to send to ev3 from ios

//  描述：本头文件用来定义各种从ios向ev3发送的信息的类型

#ifndef Ev3WifiFit_EV3MessageType_h
#define Ev3WifiFit_EV3MessageType_h

#define MESSAGE_UNLOCK 1  // 发送ev3解锁信息
#define MESSAGE_NO_REPLY 11
#define MESSAGE_GET_SENSOR_TYPE_AND_MODE 12
#define MESSAGE_READ_DATA 13
#define MESSAGE_SCAN_PORTS 14
#define MESSAGE_SCAN_SENSOR_TYPE_AND_MODE 15
#define MESSAGE_SCAN_SENSOR_DATA 16
#define MESSAGE_CLEAR 17


#define MESSAGE_UNDEFINE 0

#endif
