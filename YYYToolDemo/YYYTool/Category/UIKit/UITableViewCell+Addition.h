//
//  UITableViewCell+Addition.h
//  BaoZhangWang
//
//  Created by haiyabtx on 15/7/22.
//  Copyright (c) 2015年 BaoliNetworkTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Addition)

@property (nonatomic, assign) BOOL hiddenSeparator; /**< 隐藏分割线 */
@property (nonatomic, assign) BOOL hiddenTopSeparator; /**< 隐藏顶部分割线 */
@property (nonatomic, assign) BOOL hiddenBottomSeparatorWhenInLast;/**< 最后一个Cell隐藏分割线 */
@property (nonatomic, assign) BOOL zeroSeparatorInset; /**< 分割线无间隔 */

@property (nonatomic, assign) UIEdgeInsets topSeparatorInsert;/**< 顶部分割线 */
@property (nonatomic, assign) UIEdgeInsets bottomSeparatorInsert;/**< 底部分割线 */

+ (CGFloat)cellHeight;

+ (CGFloat)cellHeightWithValue:(id)value;

@end

