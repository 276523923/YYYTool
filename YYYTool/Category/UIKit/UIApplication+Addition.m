//
//  UIApplication+Push.m
//  CategoryUtil
//
//  Created by 李磊磊 on 13-7-24.
//  Copyright (c) 2013年 厦门 中资源. All rights reserved.
//

#import "UIApplication+Addition.h"
#include <sys/param.h>
#include <sys/mount.h>
#import <UserNotifications/UserNotifications.h>
#import "CommonMacro.h"
#import "NSString+Addition.h"

@implementation UIApplication (Addition)

#pragma -mark push methods
//是否注册
+ (BOOL)isPushRegistered
{
    UIApplication *application = [UIApplication sharedApplication];
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        return [application isRegisteredForRemoteNotifications];
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return application.enabledRemoteNotificationTypes != UIRemoteNotificationTypeNone;
#pragma clang diagnostic pop
    }
}

//注册push
+ (void)registerPush
{
    
    if (ios10AndUper)
    {
//        [self registerNotification];
        
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error) {
                NSLog(@"succeeded!");
            }
        }];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    }
    else
    {
        UIApplication *application = [UIApplication sharedApplication];
        
        //-- Set Notification
        if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
        {
            // iOS 8 Notifications
            [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
            
            [application registerForRemoteNotifications];
        }
        else
        {
            // iOS < 8 Notifications
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            [application registerForRemoteNotificationTypes:
             (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge |
              UIRemoteNotificationTypeSound)];
#pragma clang diagnostic pop
            
        }
    }
}

/**
 *  应用名称
 */
+ (NSString *)bundleDisplayName
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

/*
 *  获取项目版本号
 */
+ (NSString *)appVersion
{
    // 软件版本
    NSString *shortVersion = [self shortVersion];
    NSString *bundleVersion = [self bundleVersion];
    NSString *currentVersion = nil;
    if (bundleVersion != nil)
    {
        currentVersion = [NSString stringWithFormat:@"%@.%@",shortVersion,bundleVersion];
    }
    else
    {
        currentVersion = shortVersion;
    }
    return currentVersion;
}

/**
 *  获取项目bundle
 */
+ (NSString *)bundleVersion
{
    // 软件版本
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

/**
 *  获取项目shortVersion
 */
+ (NSString *)shortVersion
{
    // 软件版本
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (void)callPhoneWithNum:(NSString *)num
{
    if (num == nil || ![num isKindOfClass:[NSString class]] || num.length == 0) {
        return;
    }
    num = [num stringByDeletingString:@"-"];
    num = [num stringByDeletingString:@"－"];
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",num];
    if (ios10AndUper)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:nil completionHandler:nil];

    }
    else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

+ (NSInteger)getNetworkState
{
    NSArray * array = [[[UIApplication sharedApplication] valueForKeyPath:@"statusBar.foregroundView"] subviews];
    NSInteger networkType = 0;
    for (id child in array)
    {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")])
        {
            networkType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
        }
    }
    switch (networkType) {
        case 1:
            networkType = 2;
            break;
        case 2:
            networkType = 3;
            break;
        case 3:
            networkType = 4;
            break;
        case 5:
            networkType = 1;
            break;
        default:
            break;
    }
    return networkType;
}

+ (NSString *)getNewWorkStateString
{
    NSArray * array = [[[UIApplication sharedApplication] valueForKeyPath:@"statusBar.foregroundView"] subviews];
    NSInteger networkType = 0;
    for (id child in array)
    {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")])
        {
            networkType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
        }
    }
    NSString * state = @"";
    switch (networkType) {
        case 0:
            state = @"无网络";
            //无网模式
            break;
        case 1:
            state = @"2G";
            break;
        case 2:
            state = @"3G";
            break;
        case 3:
            state = @"4G";
            break;
        case 5:
            state = @"WIFI";
            break;
        default:
            break;
    }
    return state;
}

@end
