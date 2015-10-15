//
//  ViewController.m
//  EV3Car
//
//  Created by FloodSurge on 15/1/4.
//  Copyright (c) 2015年 FloodSurge. All rights reserved.
//

#import "ViewController.h"
#import <ExternalAccessory/ExternalAccessory.h>
#import "EADSessionController.h"
#import "EV3DirectCommander.h"
#import <CoreMotion/CoreMotion.h>
#import "SRMotionDetector.h"

@interface ViewController ()
{
    BOOL isConnected;
}
@property (nonatomic,strong) EADSessionController *sessionController;
@property (nonatomic,strong) EAAccessory *ev3Device;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) CMMotionManager *motionManager;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    isConnected = NO;
    /*
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.deviceMotionUpdateInterval = 0.01f;
    
    if (self.motionManager.isDeviceMotionAvailable) {
        if (!self.motionManager.isDeviceMotionActive) {
            [self.motionManager startDeviceMotionUpdates];
            
            NSLog(@"Start device motion");
            
        }
    } else NSLog(@"Device motion unavailable");
     */
    [[SRMotionDetector sharedInstance] startUpdate];

}

- (IBAction)calibration:(id)sender
{
    [[SRMotionDetector sharedInstance] reset];
}

- (IBAction)connectEv3:(UISwitch *)sender
{
    if (sender.isOn && !isConnected) {
        NSLog(@"connect EV3");
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accessoryDidConnect:) name:EAAccessoryDidConnectNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accessoryDidDisconnect:) name:EAAccessoryDidDisconnectNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionDataReceived:) name:EADSessionDataReceivedNotification object:nil];
        [[EAAccessoryManager sharedAccessoryManager] registerForLocalNotifications];
        self.sessionController = [EADSessionController sharedController];
        NSMutableArray *accessoryList = [[NSMutableArray alloc] initWithArray:[[EAAccessoryManager sharedAccessoryManager] connectedAccessories]];
        NSLog(@"accessory list:%@",accessoryList);
        if(accessoryList != nil){
            [self.sessionController setupControllerForAccessory:[accessoryList firstObject]
                                             withProtocolString:@"COM.LEGO.MINDSTORMS.EV3"];
            isConnected = [self.sessionController openSession];
            if (isConnected) {
                NSLog(@"ev3 on");
                self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(controlEV3) userInfo:nil repeats:YES];
            }
        }
        
    } else {
        [self.sessionController closeSession];
        isConnected = NO;
    
        NSLog(@"ev3 off");
        [self.timer invalidate];
        
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)accessoryDidConnect:(NSNotification *)notification {
    NSLog(@"accessory Did Connect");
    
}

- (void)accessoryDidDisconnect:(NSNotification *)notification {
    NSLog(@"accessory Did Disconnect");
    [self.timer invalidate];
}

- (void)sessionDataReceived:(NSNotification *)notification
{
}

- (void)controlEV3
{
    /*
    float pitch = self.motionManager.deviceMotion.attitude.pitch / M_PI * 180.0f;
    float yaw = self.motionManager.deviceMotion.attitude.yaw / M_PI * 180.0f;
    float roll = self.motionManager.deviceMotion.attitude.roll / M_PI * 180.0f;
    
    //NSLog(@"pitch倾斜:%f,yaw偏航:%f,roll滚转:%f",pitch,yaw,roll);
    
    
    int meanPower = (int)(- roll * 3);
    
    int offsetPower = (int)(yaw);
    
    int leftPower = meanPower - offsetPower;
    int rightPower = meanPower + offsetPower;
    
    NSLog(@"leftpower:%d,rightpower:%d",leftPower, rightPower);
    */
    
    CGPoint point = [[SRMotionDetector sharedInstance] currentPoint];
    NSLog(@"point is %f,%f",point.x,point.y);
    int meanPower = (int)(point.y * 10);
    
    int offsetPower = (int)(-point.x * 5);
    
    int leftPower = meanPower - offsetPower;
    int rightPower = meanPower + offsetPower;
    NSData *data = [EV3DirectCommander turnMotorsAtPort:EV3OutputPortB power:leftPower port:EV3OutputPortD power:rightPower];
    [[EADSessionController sharedController] writeData:data];

}

- (IBAction)stopEV3:(id)sender
{
    if (isConnected) {
        NSData *data = [EV3DirectCommander turnMotorsAtPort:EV3OutputPortB power:0 port:EV3OutputPortD power:0];
        [[EADSessionController sharedController] writeData:data];
        [self.timer invalidate];
    }
}

@end
