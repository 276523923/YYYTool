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
#import "CommonMacro.h"
#import "NSString+Addition.h"
#import "UIDevice+Addition.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

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

+ (void)registerPushWithNotificationCenterDelegate:(id)delegate
{
    
    UIApplication *application = [UIApplication sharedApplication];
    if (kiOS10Later)
    {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = delegate;
        UNAuthorizationOptions options = UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
        [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error) {
                NSLog(@"succeeded!");
                
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    NSLog(@"%@", settings);
                }];
                
                [application registerForRemoteNotifications];
            }
        }];
    }
    else
    {
        // iOS 8 Notifications
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [application registerForRemoteNotifications];
    }
}

//注册push
+ (void)registerPush
{
    [self registerPushWithNotificationCenterDelegate:nil];
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
    if (kiOS10Later)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
    }
    else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}


@end
