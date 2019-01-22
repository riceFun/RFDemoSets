//
//  ViewController.m
//  NotificationForever
//
//  Created by riceFun on 2019/1/21.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.button addTarget:self action:@selector(sendNotification) forControlEvents:(UIControlEventTouchUpInside)];
}


//发送一个通知
- (void)sendNotification {
    UNTimeIntervalNotificationTrigger *timeTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3.0f repeats:NO];
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"App探索-NotFound";
    content.body = @"[App探索]JSBox中幽灵触发器的实现原理探索";
    content.badge = @1;
    content.categoryIdentifier = @"NotificationForeverCategory";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"requestIdentifier" content:content trigger:timeTrigger];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler: nil];
}


@end
