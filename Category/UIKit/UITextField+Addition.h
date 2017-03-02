//
//  UITextField+Addition.h
//  BaoZhangWang
//
//  Created by 叶越悦 on 15/10/13.
//  Copyright © 2015年 BaoliNetworkTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Addition)

@property (nonatomic, assign) UIEdgeInsets textRectInsets;
@property (nonatomic, strong) UILabel *yyy_placeholderLabel;

/**
 *  @author 叶越悦, 15-10-13 14:53:23
 *
 *  快速创建TextField
 *
 *  @return TextField
 */
+ (instancetype)createTextField;

/**
 *  @author 叶越悦, 15-10-13 14:53:47
 *
 *  快速创建TextField - 带 placeholder
 *
 *  @param placeholder placeholder
 *
 *  @return TextFile
 */
+ (instancetype)createTextFieldWithPlaceholder:(NSString *)placeholder;

/**
 *  @author 叶越悦, 15-10-13 14:54:14
 *
 *  快速创建TextField - 带 text
 *
 *  @param text text
 *
 *  @return TextFile
 */
+ (instancetype)createTextFieldWithDefaultText:(NSString *)text;


@end
