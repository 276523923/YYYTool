//
//  UIView+SetFrameAddition.m
//  BossmailQ
//
//  Created by chen shengzhi on 12-11-5.
//  Copyright (c) 2012年 zzy. All rights reserved.
//

#import "UIView+SetFrameAddition.h"
#import <objc/runtime.h>

@implementation UIView (SetFrameAddition)


- (CGFloat)f_left
{
    return self.frame.origin.x;
}

- (void)setF_left:(CGFloat)f_left
{
    CGRect frame = self.frame;
    frame.origin.x = f_left;
    self.frame = frame;
}

- (CGFloat)f_top
{
    return self.frame.origin.y;
}

- (void)setF_top:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)f_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setF_right:(CGFloat)f_right
{
    CGRect frame = self.frame;
    frame.origin.x = f_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)f_bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setF_bottom:(CGFloat)f_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = f_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)f_width
{
    return CGRectGetWidth(self.frame);
}

- (void)setF_width:(CGFloat)f_width
{
    CGRect frame = self.frame;
    frame.size.width = f_width;
    self.frame = frame;
}

- (CGFloat)f_height
{
    return CGRectGetHeight(self.frame);
}

- (void)setF_height:(CGFloat)f_height
{
    CGRect frame = self.frame;
    frame.size.height = f_height;
    self.frame = frame;
}

- (CGFloat)f_centerX
{
    return self.center.x;
}

- (void)setF_centerX:(CGFloat)f_centerX
{
    self.center = CGPointMake(f_centerX, self.center.y);
}

- (CGFloat)f_centerY
{
    return self.center.y;
}

- (void)setF_centerY:(CGFloat)f_centerY
{
    self.center = CGPointMake(self.center.x, f_centerY);
}

- (CGPoint)f_origin
{
    return self.frame.origin;
}

- (void)setF_origin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)f_size
{
    return self.frame.size;
}

- (void)setF_size:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setX:(CGFloat)x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (void)setY:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (void)setWidth:(CGFloat)w
{
    CGRect rect = self.frame;
    rect.size.width = w;
    self.frame = rect;
}

- (void)setHeight:(CGFloat)h
{
    CGRect rect = self.frame;
    rect.size.height = h;
    self.frame = rect;
}

- (void)setPoint:(CGPoint)point
{
    CGRect rect = self.frame;
    rect.origin = point;
    self.frame = rect;
}

- (void)setSize:(CGSize)size
{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

#pragma CGRect Get Set

- (CGFloat)minX
{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)minY
{
    return CGRectGetMinY(self.frame);
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

- (void)setMinX:(CGFloat)minX
{
    [self setX:minX];
}

- (void)setMaxX:(CGFloat)maxX
{
    self.minX = maxX-self.fWidth;
}

- (void)setMinY:(CGFloat)minY
{
    [self setY:minY];
}

- (void)setMaxY:(CGFloat)maxY
{
    self.minY = maxY-self.fHeight;
}

- (CGFloat)fHeight
{
    return CGRectGetHeight(self.frame);
}

- (CGFloat)fWidth
{
    return CGRectGetWidth(self.frame);
}

- (void)setFHeight:(CGFloat)fHeight
{
    [self setHeight:fHeight];
}

- (void)setFWidth:(CGFloat)fWidth
{
    [self setWidth:fWidth];
}

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

#ifdef DEBUG
#pragma mark - 打印所有子视图层次 -
/**
 *	私有方法, 打印视图及所有子视图, 并且有层次
 *
 *	@return id
 */
- (id)recursiveDescription_
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    return [self performSelector:@selector(recursiveDescription)];
#pragma clang diagnostic pop
}
#endif

/**
 *  @author 叶越悦, 15-07-24 09:09:04
 *
 *  设置边框宽度与颜色
 *
 *  @param width 宽度
 *  @param color 颜色
 */
- (void)setBorderWidth:(CGFloat) width andBorderColor:(UIColor *)color
{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

/**
 *  @author 叶越悦, 15-08-10 10:32:22
 *
 *  设置单边圆角
 *
 *  @param corners     要设置的圆角
 *  @param cornerRadii 圆角值
 */
- (void)setRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii
{
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    self.layer.masksToBounds = YES;
}

@end
