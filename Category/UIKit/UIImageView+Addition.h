//
//  UIImageView+Addition.h
//  BaoZhangWang
//
//  Created by 叶越悦 on 15/9/16.
//  Copyright (c) 2015年 BaoliNetworkTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Addition)
@property (nonatomic, assign) BOOL circleImage;/**< 圆形 */

/**
 *  @author 叶越悦, 15-09-16 10:05:13
 *
 *  添加边框
 *
 *  @param offset 偏移量
 *  @param width  边框宽度
 *  @param color  边框颜色
 */
-(void)addBordersOffset:(CGFloat) offset borderWidth:(CGFloat)width borderColor:(UIColor *)color;

-(void)addBordersFrame:(CGRect)frame borderWidth:(CGFloat)width borderColor:(UIColor *)color;


@end
