//
//  UIView+YYYConstraints.h
//  BaoZhangWang
//
//  Created by 叶越悦 on 2017/2/21.
//  Copyright © 2017年 yyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YYYConstraints)
@property (nonatomic, assign) BOOL isSetupConstraints;

/**
 可以在这边添加子View的约束，这个会在第一次调用updateConstraints的时候执行一次。
 */
- (void)yyy_setupViewsConstraints __attribute__((objc_requires_super));

@end
