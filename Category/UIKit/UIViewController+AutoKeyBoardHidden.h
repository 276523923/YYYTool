//
//  UIViewController+AutoKeyBoardHidden.h
//  BaoZhangWang
//
//  Created by yyy on 16/7/11.
//  Copyright © 2016年 yyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AutoKeyBoardHidden)

@property (nonatomic, assign) BOOL autoHiddenKeyBoardWhenTapView;/**< 点击view自动隐藏键盘 */
- (void)keyboardWillHidde:(UITapGestureRecognizer*)tap;

@end
