//
//  UIViewController+AutoKeyBoardHidden.m
//  BaoZhangWang
//
//  Created by yyy on 16/7/11.
//  Copyright © 2016年 yyy. All rights reserved.
//

#import "UIViewController+AutoKeyBoardHidden.h"
#import <objc/runtime.h>
#import "NSObject+Addition.h"

//防止UITextField点击清空按钮的时候隐藏了键盘
@interface MyTapGestureRecognizerDelegate : NSObject<UIGestureRecognizerDelegate>

@end

@implementation MyTapGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UIButton class]] &&
        touch.view.superview &&
        [touch.view.superview isKindOfClass:[UITextField class]]) {
        return NO;
    }
    return YES;
}

@end

@interface UIViewController ()

@property (nonatomic, strong) UITapGestureRecognizer *hiddenKeyBoardTapGestureRecognizer;/**< 点击隐藏键盘手势 */
@property (nonatomic, strong) MyTapGestureRecognizerDelegate *myTapGestureRecognizerDelegate;
@property (nonatomic, assign) BOOL isRegisterKeyBoardNot;/**< 是否注册键盘通知 */

@end

@implementation UIViewController (AutoKeyBoardHidden)

+ (void)load
{
    [self swizzleSelector:@selector(viewWillAppear:) swapSelector:@selector(yyy_keyboard_viewWillAppear:)];
    [self swizzleSelector:@selector(viewWillDisappear:) swapSelector:@selector(yyy_keyboard_viewWillDisappear:)];
}

- (void)yyy_keyboard_viewWillAppear:(BOOL)animated
{
    [self yyy_keyboard_viewWillAppear:animated];
    self.isRegisterKeyBoardNot = self.autoHiddenKeyBoardWhenTapView;
}

- (void)yyy_keyboard_viewWillDisappear:(BOOL)animated
{
    [self yyy_keyboard_viewWillDisappear:animated];
    self.isRegisterKeyBoardNot = NO;
}

#pragma mark - keyBoard Handle

- (void)registerKeyBoardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bzw_keyBoardShowHandle) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bzw_keyBoardHiddenHandle) name:UIKeyboardDidHideNotification object:nil];
}

- (void)unregisterKeyBoardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [self.view removeGestureRecognizer:self.hiddenKeyBoardTapGestureRecognizer];
}

- (void)bzw_keyBoardShowHandle
{
    [self.view addGestureRecognizer:self.hiddenKeyBoardTapGestureRecognizer];
}

- (void)bzw_keyBoardHiddenHandle
{
    [self.view removeGestureRecognizer:self.hiddenKeyBoardTapGestureRecognizer];
}

/**
 *  隐藏键盘的方法
 */
- (void)keyboardWillHidde:(UITapGestureRecognizer*)tap
{
    [self.view performSelector:@selector(endEditing:) withObject:@(YES) afterDelay:.1];
}

#pragma mark - get,set

- (BOOL)autoHiddenKeyBoardWhenTapView
{
    return [objc_getAssociatedObject(self, @selector(autoHiddenKeyBoardWhenTapView)) boolValue];
}

- (void)setAutoHiddenKeyBoardWhenTapView:(BOOL)autoHiddenKeyBoardWhenTapView
{
    self.isRegisterKeyBoardNot = autoHiddenKeyBoardWhenTapView;
    objc_setAssociatedObject(self, @selector(autoHiddenKeyBoardWhenTapView), @(autoHiddenKeyBoardWhenTapView), OBJC_ASSOCIATION_RETAIN);
}

- (UITapGestureRecognizer *)hiddenKeyBoardTapGestureRecognizer
{
    UITapGestureRecognizer *tap = objc_getAssociatedObject(self, @selector(hiddenKeyBoardTapGestureRecognizer));
    if (!tap)
    {
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardWillHidde:)];
        tap.cancelsTouchesInView = NO;
        tap.delegate = self.myTapGestureRecognizerDelegate;
        objc_setAssociatedObject(self, @selector(hiddenKeyBoardTapGestureRecognizer), tap, OBJC_ASSOCIATION_RETAIN);
    }
    return tap;
}

- (MyTapGestureRecognizerDelegate *)myTapGestureRecognizerDelegate
{
    MyTapGestureRecognizerDelegate *delegate = objc_getAssociatedObject(self, @selector(myTapGestureRecognizerDelegate));
    if (!delegate)
    {
        delegate = [MyTapGestureRecognizerDelegate new];
        objc_setAssociatedObject(self, @selector(myTapGestureRecognizerDelegate), delegate, OBJC_ASSOCIATION_RETAIN);
    }
    return delegate;
}

- (BOOL)isRegisterKeyBoardNot
{
    return [objc_getAssociatedObject(self, @selector(isRegisterKeyBoardNot)) boolValue];
}

- (void)setIsRegisterKeyBoardNot:(BOOL)isRegisterKeyBoardNot
{
    if (self.isRegisterKeyBoardNot == isRegisterKeyBoardNot)
    {
        return;
    }
    else
    {
        objc_setAssociatedObject(self, @selector(isRegisterKeyBoardNot), @(isRegisterKeyBoardNot), OBJC_ASSOCIATION_RETAIN);
        if (isRegisterKeyBoardNot)
        {
            [self registerKeyBoardNotification];
        }
        else
        {
            [self unregisterKeyBoardNotification];
        }
    }
}

@end
