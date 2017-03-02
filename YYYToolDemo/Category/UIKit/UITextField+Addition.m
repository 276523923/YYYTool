//
//  UITextField+Addition.m
//  BaoZhangWang
//
//  Created by 叶越悦 on 15/10/13.
//  Copyright © 2015年 BaoliNetworkTechnology. All rights reserved.
//

#import "UITextField+Addition.h"
#import <objc/runtime.h>
#import "NSObject+Addition.h"

@implementation UITextField (Addition)

+ (void)load
{
    [self swizzleSelector:@selector(yyy_textRectForBounds:) swapSelector:@selector(textRectForBounds:)];
    [self swizzleSelector:@selector(yyy_editingRectForBounds:) swapSelector:@selector(editingRectForBounds:)];
    [self swizzleSelector:@selector(yyy_clearButtonRectForBounds:) swapSelector:@selector(clearButtonRectForBounds:)];
}

- (UILabel *)yyy_placeholderLabel
{
    return [self valueForKey:@"_placeholderLabel"];
}

- (void)setYyy_placeholderLabel:(UILabel *)yyy_placeholderLabel
{
    [self setValue:yyy_placeholderLabel forKey:@"_placeholderLabel"];
}

//默认配置
+ (instancetype)createTextField
{
    UITextField *textField = [[[self class] alloc]init];
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.font = [UIFont systemFontOfSize:15];
    return textField;
}

+ (instancetype)createTextFieldWithPlaceholder:(NSString *)placeholder
{
    UITextField * textField = [self createTextField];
    textField.placeholder = placeholder;
    return textField;
}

+ (instancetype)createTextFieldWithDefaultText:(NSString *)text
{
    UITextField * textField = [self createTextField];
    textField.text = text;
    return textField;
}

- (CGRect)yyy_textRectForBounds:(CGRect)bounds
{
    CGRect rect = [self yyy_textRectForBounds:bounds];
    NSValue *value = objc_getAssociatedObject(self, @selector(textRectInsets));
    if (!value)
    {
        return rect;
    }
    UIEdgeInsets insert = [value UIEdgeInsetsValue];
    rect.origin.x += insert.left;
    rect.origin.y += insert.top;
    rect.size.width -= insert.left + insert.right;
    rect.size.width -= insert.top + insert.bottom;
    return  rect;
}

- (CGRect)yyy_editingRectForBounds:(CGRect)bounds
{
    CGRect rect = [self yyy_editingRectForBounds:bounds];
    NSValue *value = objc_getAssociatedObject(self, @selector(textRectInsets));
    if (!value)
    {
        return rect;
    }
    UIEdgeInsets insert = [value UIEdgeInsetsValue];
    rect.origin.x += insert.left;
    rect.origin.y += insert.top;
    rect.size.width -= insert.left + insert.right;
    rect.size.width -= insert.top + insert.bottom;
    return  rect;
}

- (CGRect)yyy_clearButtonRectForBounds:(CGRect)bounds
{
    CGRect rect = [self yyy_clearButtonRectForBounds:bounds];
    NSValue *value = objc_getAssociatedObject(self, @selector(textRectInsets));
    if (!value)
    {
        return rect;
    }
    UIEdgeInsets insert = [value UIEdgeInsetsValue];
    rect.origin.x -= insert.right;
    rect.origin.y += insert.top;
    return  rect;
}

- (UIEdgeInsets)textRectInsets
{
    return [objc_getAssociatedObject(self, @selector(textRectInsets)) UIEdgeInsetsValue];
}

- (void)setTextRectInsets:(UIEdgeInsets)textRectInsets
{
    NSValue *value = [NSValue valueWithUIEdgeInsets:textRectInsets];
    if (UIEdgeInsetsEqualToEdgeInsets(textRectInsets, UIEdgeInsetsZero))
    {
        value = nil;
    }
    objc_setAssociatedObject(self, @selector(textRectInsets), value, OBJC_ASSOCIATION_RETAIN);
}

@end
