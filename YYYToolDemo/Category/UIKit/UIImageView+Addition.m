//
//  UIImageView+Addition.m
//  BaoZhangWang
//
//  Created by 叶越悦 on 15/9/16.
//  Copyright (c) 2015年 BaoliNetworkTechnology. All rights reserved.
//

#import "UIImageView+Addition.h"
#import <objc/runtime.h>
#import "NSObject+Addition.h"
#import "UIView+SetFrameAddition.h"

@implementation UIImageView (Addition)

+ (void)load
{
    [self swizzleSelector:@selector(layoutSubviews) swapSelector:@selector(circleImage_layoutSubviews)];
}

- (void)circleImage_layoutSubviews
{
    [self circleImage_layoutSubviews];
    if (self.circleImage)
    {
        self.cornerRadius = MIN(self.fWidth, self.fHeight)/2;
    }
}

- (void)addBordersOffset:(CGFloat)offset borderWidth:(CGFloat)width borderColor:(UIColor *)color {
    CGRect frame = CGRectMake(-offset, -offset, self.frame.size.width + 2*offset , self.frame.size.height + 2*offset);
    [self addBordersFrame:frame borderWidth:width borderColor:color];
}

-(void)addBordersFrame:(CGRect)frame borderWidth:(CGFloat)width borderColor:(UIColor *)color {
    CALayer * grayCover = [[CALayer alloc] initWithLayer:self.layer];
    grayCover.frame = frame;
    grayCover.borderWidth = width;
    grayCover.borderColor = color.CGColor;
    [self.layer addSublayer:grayCover];
}

- (void)setCircleImage:(BOOL)circleImage
{
    objc_setAssociatedObject(self, @selector(circleImage), @(circleImage), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)circleImage
{
    return [objc_getAssociatedObject(self, @selector(circleImage)) boolValue];
}

@end
