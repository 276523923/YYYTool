//
//  UIView+SetFrameAddition.h
//  BossmailQ
//
//  Created by chen shengzhi on 12-11-5.
//  Copyright (c) 2012年 zzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView ()

// 修改以下值 只会进行视图移动，不会修改 视图大小
@property (nonatomic) CGFloat maxX;
@property (nonatomic) CGFloat minX;
@property (nonatomic) CGFloat minY;
@property (nonatomic) CGFloat maxY;

//视图大小
@property (nonatomic) CGFloat fHeight;
@property (nonatomic) CGFloat fWidth;

@property (nonatomic, assign) CGFloat cornerRadius;/**< 圆角 */

@end

@interface UIView (SetFrameAddition)

#ifdef DEBUG
#pragma mark - 打印所有子视图层次 -
/**
 *	私有方法, 打印视图及所有子视图, 并且有层次
 *
 *	@return id
 */
- (id)recursiveDescription_;
#endif

/**
 *  @author 叶越悦, 15-07-24 09:09:23
 *
 *  设置边框宽度与颜色
 *
 *  @param width 宽度
 *  @param color 颜色
 */
- (void)setBorderWidth:(CGFloat) width andBorderColor:(UIColor *)color;

/**
 *  @author 叶越悦, 15-08-10 10:32:22
 *
 *  设置单边圆角
 *
 *  @param corners     要设置的圆角
 *  @param cornerRadii 圆角值
 */
- (void)setRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;


@end
