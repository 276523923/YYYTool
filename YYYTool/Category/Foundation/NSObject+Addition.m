//
//  NSObject+Addition.m
//  YYYTool
//
//  Created by 叶越悦 on 2017/3/2.
//  Copyright © 2017年 叶越悦. All rights reserved.
//

#import "NSObject+Addition.h"
#import <objc/runtime.h>

@implementation NSObject (Addition)

-(NSString *)classString
{
    return NSStringFromClass([self class]);
}

+ (void)swizzleSelector:(SEL)origSelector swapSelector:(SEL)swapSelector
{
    Class cls = [self class];
    Method originalMethod = class_getInstanceMethod(cls, origSelector);
    Method swapMethod = class_getInstanceMethod(cls, swapSelector);
    if (!originalMethod || !swapSelector)
    {
        return;
    }
#ifdef DEBUG
    NSLog(@"%@ swizzle SEL <-> %@  swap SEL:%@",NSStringFromClass(cls),NSStringFromSelector(origSelector),NSStringFromSelector(swapSelector));
#endif
    method_exchangeImplementations(originalMethod, swapMethod);
}

+ (BOOL)classMethodRespondsToSelector:(SEL)aSelector
{
    if (aSelector == nil)
    {
        return NO;
    }
    Method aaaMethod = class_getClassMethod([self class], aSelector);
    return aaaMethod != nil;
}

@end
