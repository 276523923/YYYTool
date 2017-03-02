//
//  UITextField+InputLimit.m
//
//  Created by 叶越悦 on 15/7/13.
//  Copyright (c) 2015年 叶越悦. All rights reserved.
//

#import "UITextField+InputLimit.h"
#import <objc/runtime.h>
#import "NSString+Addition.h"

@interface UITextField()

@property (nonatomic, copy) NSString *oldString__;/**< 用来记录之前的字符串*/

@end

@implementation UITextField (InputLimit)

#pragma mark - 重写set/get方法 -

- (void)setMaxLength:(NSInteger)maxLength
{
    if (maxLength > 0)//大于0才进行限制，小于等于0为不限
    {
        [self addTarget:self action:@selector(textFieldInputLimitMaxLeng:) forControlEvents:UIControlEventEditingChanged];
    }
    else
    {
        [self removeTarget:self action:@selector(textFieldInputLimitMaxLeng:) forControlEvents:UIControlEventEditingChanged];
    }
    objc_setAssociatedObject(self, @selector(maxLength), @(maxLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)maxLength
{
    return [objc_getAssociatedObject(self, @selector(maxLength)) intValue];
}

- (void)setDecimalDigits:(NSInteger)decimalDigits
{
    if (decimalDigits > 0)
    {
        self.inputType = TextFieldInputTypeDoubleOnly;
        [self addTarget:self action:@selector(textFieldInputDecimalDigits:) forControlEvents:UIControlEventEditingChanged];
    }
    else
    {
        [self removeTarget:self action:@selector(textFieldInputDecimalDigits:) forControlEvents:UIControlEventEditingChanged];
    }
    objc_setAssociatedObject(self, @selector(decimalDigits), @(decimalDigits), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSInteger)decimalDigits
{
    return [objc_getAssociatedObject(self, @selector(decimalDigits)) intValue];
}

- (void)setInputType:(TextFieldInputType)inputType
{
    switch (inputType) {
        case TextFieldInputTypeAll:
        {
            self.keyboardType = UIKeyboardTypeDefault;
            break;
        }
        case TextFieldInputTypeIntOnly:
        {
            self.keyboardType = UIKeyboardTypeNumberPad;
            if (![self.text isPureInt])
            {
                self.text = @"";
            }
            break;
        }
        case TextFieldInputTypeDoubleOnly:
        {
            self.keyboardType = UIKeyboardTypeDecimalPad;
            if (![self.text isPureFloat])
            {
                self.text = @"";
            }
            break;
        }
        default:
            break;
    }
    if (inputType != TextFieldInputTypeAll)
    {
        [self addTarget:self action:@selector(textFieldInputTypeLimit:) forControlEvents:UIControlEventEditingChanged];
    }
    else
    {
        [self removeTarget:self action:@selector(textFieldInputTypeLimit:) forControlEvents:UIControlEventEditingChanged];
    }
    
    objc_setAssociatedObject(self, @selector(inputType), @(inputType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TextFieldInputType)inputType
{
    return [objc_getAssociatedObject(self, @selector(inputType)) intValue];
}

- (void)setOldString__:(NSString *)oldString__
{
    objc_setAssociatedObject(self, @selector(oldString__), oldString__, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)oldString__
{
    return objc_getAssociatedObject(self, @selector(oldString__));
}

#pragma mark - target -

/**
 *  限制长度方法
 */
- (void)textFieldInputLimitMaxLeng:(UITextField *)textField
{
    UITextRange * selectedRange = [textField markedTextRange];
    if(selectedRange == nil || selectedRange.empty)
    {
        if (textField.text.length > textField.maxLength)
        {
            textField.text = [textField.text substringToIndex:textField.maxLength];
        }
    }
}

- (void)textFieldInputDecimalDigits:(UITextField *)textField
{
    UITextRange * selectedRange = [textField markedTextRange];
    if(selectedRange == nil || selectedRange.empty)
    {
        NSRange decimalPoint=[textField.text rangeOfString:@"." options:NSCaseInsensitiveSearch];
        if (decimalPoint.length > 0 &&
            (textField.text.length - decimalPoint.location >self.decimalDigits + 1))
        {
            NSRange range = NSMakeRange(0, decimalPoint.location + self.decimalDigits+1);
            textField.text = [textField.text substringWithRange:range];
            self.oldString__ = textField.text;
        }        
    }
}

- (void)textFieldInputTypeLimit:(UITextField *)textField
{
    UITextRange * selectedRange = [textField markedTextRange];
    if(selectedRange == nil || selectedRange.empty)
    {
        if (textField.text.length == 0)
        {
            self.oldString__ = textField.text;
            return;
        }
        if ([textField.text isEqualToString:self.oldString__])
        {
            return;
        }
        if ([[textField.text trim] isEqualToString:self.oldString__] &&
            self.inputType != TextFieldInputTypeAll)//数字不允许输入空格
        {
            textField.text = self.oldString__;
            return;
        }
        switch (self.inputType)
        {
            case TextFieldInputTypeIntOnly:
            {
                NSScanner* scan = [NSScanner scannerWithString:textField.text];
                int val;
                if (!([scan scanInt:&val] && [scan isAtEnd]))
                {
                    textField.text = self.oldString__;
                }
                break;
            }
            case TextFieldInputTypeDoubleOnly:
            {
                NSScanner* scan = [NSScanner scannerWithString:textField.text];
                double val;
                if (!([scan scanDouble:&val] && [scan isAtEnd]))
                {
                    textField.text = self.oldString__;
                }
                break;
            }
            default:
                break;
        }
        self.oldString__ = textField.text;
    }
}

@end
