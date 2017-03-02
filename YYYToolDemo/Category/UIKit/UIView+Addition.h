//
//  UIView+Addition.h
//  BaoZhangWangiPad
//
//  Created by yyy on 15/12/14.
//  Copyright © 2015年 yyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addition)

- (__kindof UIView *)viewMatchingPredicate:(NSPredicate *)predicate;
- (__kindof UIView *)viewWithTag:(NSInteger)tag ofClass:(Class)viewClass;
- (__kindof UIView *)viewOfClass:(Class)viewClass;

- (NSArray<__kindof UIView *> *)viewsMatchingPredicate:(NSPredicate *)predicate;
- (NSArray<__kindof UIView *> *)viewsWithTag:(NSInteger)tag;
- (NSArray<__kindof UIView *> *)viewsWithTag:(NSInteger)tag ofClass:(Class)viewClass;
- (NSArray<__kindof UIView *> *)viewsOfClass:(Class)viewClass;

- (__kindof UIView *)firstSuperviewMatchingPredicate:(NSPredicate *)predicate;
- (__kindof UIView *)firstSuperviewOfClass:(Class)viewClass;
- (__kindof UIView *)firstSuperviewWithTag:(NSInteger)tag;
- (__kindof UIView *)firstSuperviewWithTag:(NSInteger)tag ofClass:(Class)viewClass;

- (BOOL)viewOrAnySuperviewMatchesPredicate:(NSPredicate *)predicate;
- (BOOL)viewOrAnySuperviewIsKindOfClass:(Class)viewClass;
- (BOOL)isSuperviewOfView:(UIView *)view;
- (BOOL)isSubviewOfView:(UIView *)view;

- (UIViewController *)firstViewController;
- (__kindof UIView *)firstResponder;

@end
