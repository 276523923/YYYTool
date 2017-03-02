//
//  UIColor+Addition.m
//  YYYTool
//
//  Created by 叶越悦 on 2017/3/2.
//  Copyright © 2017年 叶越悦. All rights reserved.
//

#import "UIColor+Addition.h"

@implementation UIColor (Addition)
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

+ (NSString *)hexFromUIColor:(UIColor*)color {
    if (color == nil || ![color isKindOfClass:[UIColor class]])
    {
        return @"#FFFFFF";
    }
    return [color hexColorString];
}

#pragma mark - web
/**
 *  @brief  获取canvas用的颜色字符串
 *
 *  @return canvas颜色
 */
- (NSString *)RGBColorString
{
    CGFloat *arrRGBA = [self getRGB];
    int r = arrRGBA[0] * 255;
    int g = arrRGBA[1] * 255;
    int b = arrRGBA[2] * 255;
    float a = arrRGBA[3];
    return [NSString stringWithFormat:@"rgba(%d,%d,%d,%f)", r, g, b, a];
}
/**
 *  @brief  获取网页颜色字串
 *
 *  @return 网页颜色
 */
- (NSString *)hexColorString
{
    CGFloat *arrRGBA = [self getRGB];
    int r = arrRGBA[0] * 255;
    int g = arrRGBA[1] * 255;
    int b = arrRGBA[2] * 255;
    NSString *webColor = [NSString stringWithFormat:@"#%02X%02X%02X", r, g, b];
    return webColor;
}

- (CGFloat *)getRGB
{
    UIColor * uiColor = self;
    CGColorRef cgColor = [uiColor CGColor];
    int numComponents = (int)CGColorGetNumberOfComponents(cgColor);
    if (numComponents == 4){
        static CGFloat * components = Nil;
        components = (CGFloat *) CGColorGetComponents(cgColor);
        return (CGFloat *)components;
    } else { //否则默认返回黑色
        static CGFloat components[4] = {0};
        CGFloat f = 0;
        //非RGB空间的系统颜色单独处理
        if ([uiColor isEqual:[UIColor whiteColor]]) {
            f = 1.0;
        } else if ([uiColor isEqual:[UIColor lightGrayColor]]) {
            f = 0.8;
        } else if ([uiColor isEqual:[UIColor grayColor]]) {
            f = 0.5;
        }
        components[0] = f;
        components[1] = f;
        components[2] = f;
        components[3] = 1.0;
        return (CGFloat *)components;
    }
}

@end
