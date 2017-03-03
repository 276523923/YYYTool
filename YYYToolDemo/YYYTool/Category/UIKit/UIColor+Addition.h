//
//  UIColor+Addition.h
//  YYYTool
//
//  Created by 叶越悦 on 2017/3/2.
//  Copyright © 2017年 叶越悦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Addition)
/**
 *  @author 尹少波, 15-08-05 11:42
 *
 *  十六进制color,可设置透明度
 *
 *  @param color 十六进制字符串
 *  @param alpha 透明度
 *
 *  @return 十六进制色值
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 *  @author 尹少波, 15-08-05 11:41
 *
 *  十六进制color，默认透明度为1
 *
 *  @param color 十六进制字符串
 *
 *  @return 十六进制色值
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

+ (NSString *)hexFromUIColor: (UIColor*)color;
/**
 *  @brief  获取canvas用的颜色字符串
 *
 *  @return canvas颜色
 */
- (NSString *)RGBColorString;
/**
 *  @brief  获取网页颜色字串
 *
 *  @return 网页颜色
 */
- (NSString *)hexColorString;

@end
