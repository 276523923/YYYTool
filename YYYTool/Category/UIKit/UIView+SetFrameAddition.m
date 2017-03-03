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
