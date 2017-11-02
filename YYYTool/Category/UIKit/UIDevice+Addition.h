//
//  UIDevice+Addition.h
//  YYYTool
//
//  Created by 叶越悦 on 2017/3/2.
//  Copyright © 2017年 叶越悦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Addition)

/// Device system version (e.g. 8.1)
+ (CGFloat)systemVersion;
/// The device's machine model.  e.g. "iPhone6,1" "iPad4,6"
/// @see http://theiphonewiki.com/wiki/Models
@property (nullable, nonatomic, readonly) NSString *machineModel;

/// The device's machine model name. e.g. "iPhone 5s" "iPad mini 2"
/// @see http://theiphonewiki.com/wiki/Models
@property (nullable, nonatomic, readonly) NSString *machineModelName;
@property (nonatomic, readonly) BOOL isPad;

@end
