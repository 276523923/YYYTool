//
//  UIDevice+Addition.h
//  YYYTool
//
//  Created by 叶越悦 on 2017/3/2.
//  Copyright © 2017年 叶越悦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Addition)

@property (nonatomic, strong, readonly)NSString *deviceModelString;
+ (NSString *)deviceModelString;

@end
