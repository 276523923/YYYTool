//
//  UIView+YYYConstraints.m
//  BaoZhangWang
//
//  Created by 叶越悦 on 2017/2/21.
//  Copyright © 2017年 yyy. All rights reserved.
//

#import "UIView+YYYConstraints.h"
#import <objc/runtime.h>
#import "NSObject+Addition.h"

@interface UIView ()
@property (nonatomic, assign) BOOL isSetupConstraints;
@end

@implementation UIView (YYYConstraints)

+ (void)load
{
    [self swizzleSelector:@selector(updateConstraints) swapSelector:@selector(yyy_updateConstraints)];
}

- (void)yyy_updateConstraints
{
    [self yyy_updateConstraints];
    if (!self.isSetupConstraints)
    {
        [self yyy_setupViewsConstraints];
        self.isSetupConstraints = YES;
    }
}

- (void)yyy_setupViewsConstraints
{
    self.isSetupConstraints = YES;
}

- (void)setIsSetupConstraints:(BOOL)isSetupConstraints
{
    objc_setAssociatedObject(self, @selector(isSetupConstraints), @(isSetupConstraints), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isSetupConstraints
{
    return [objc_getAssociatedObject(self, @selector(isSetupConstraints)) boolValue];
}

@end
