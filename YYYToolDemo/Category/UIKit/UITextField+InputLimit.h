//
//  UITextField+InputLimit.h
//
//  Created by 叶越悦 on 15/7/13.
//  Copyright (c) 2015年 叶越悦. All rights reserved.
//

#import <UIKit/UIKit.h>

//输入类型
typedef NS_ENUM(NSUInteger, TextFieldInputType) {
    TextFieldInputTypeAll,       //任意
    TextFieldInputTypeIntOnly,   //整形
    TextFieldInputTypeDoubleOnly, //浮点型
};

/**
 *  限制UITextField的输入
 */
@interface UITextField (InputLimit)

@property (nonatomic, assign) NSInteger maxLength; /**< 输入长度 */
@property (nonatomic, assign) NSInteger decimalDigits; /**< 小数位数，设置的话会将inputType设置为TextFieldInputTypeDoubleOnly */
@property (nonatomic, assign) TextFieldInputType inputType; /**< 输入类型 */

@end
