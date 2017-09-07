//
//  UIApplication+Push.h
//  CategoryUtil
//
//  Created by 李磊磊 on 13-7-24.
//  Copyright (c) 2013年 厦门 中资源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (Addition)

#pragma -mark push methods
+ (BOOL)isPushRegistered;   //是否注册
+ (void)registerPush;       //注册push
+ (void)registerPushWithNotificationCenterDelegate:(id)delegate;

/**
 *  应用名称
 */
+ (NSString *)bundleDisplayName;

/*
 *  获取项目版本号 "%@.%@"
 */
+ (NSString *)appVersion;

/**
 *  获取项目bundle
 */
+ (NSString *)bundleVersion;

/**
 *  获取项目shortVersion
 */
+ (NSString *)shortVersion;

/**
 *  @author 叶越悦, 15-08-02 16:48:19
 *
 *  拨打电话
 *
 *  @param num 电话号码
 */
+ (void)callPhoneWithNum:(NSString *)num;

+ (void)jumpSystemSetting;

@end
