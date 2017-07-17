//
//  CALayer+SetFrameAddition.m
//  Pods
//
//  Created by 叶越悦 on 2017/7/17.
//
//

#import "CALayer+SetFrameAddition.h"

@implementation CALayer (SetFrameAddition)

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

- (CGPoint)f_center
{
    return CGPointMake(self.frame.origin.x + self.frame.size.width * 0.5,
                       self.frame.origin.y + self.frame.size.height * 0.5);
}

- (void)setF_center:(CGPoint)f_center
{
    CGRect frame = self.frame;
    frame.origin.x = f_center.x - frame.size.width * 0.5;
    frame.origin.y = f_center.y - frame.size.height * 0.5;
    self.frame = frame;
}

- (CGFloat)f_centerX
{
    return self.f_center.x;
}

- (void)setF_centerX:(CGFloat)f_centerX
{
    self.f_center = CGPointMake(f_centerX, self.f_center.y);
}

- (CGFloat)f_centerY
{
    return self.f_center.y;
}

- (void)setF_centerY:(CGFloat)f_centerY
{
    self.f_center = CGPointMake(self.f_center.x, f_centerY);
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
@end
