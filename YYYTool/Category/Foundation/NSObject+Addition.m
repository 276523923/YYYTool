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
    Method originalMethod = class_getInstanceMethod(self, origSelector);
    Method newMethod = class_getInstanceMethod(self, swapSelector);
    if (!originalMethod || !newMethod) return;
    
#if DEBUG
    NSLog(@"%@ swizzle SEL <-> %@  swap SEL:%@",NSStringFromClass(cls),NSStringFromSelector(origSelector),NSStringFromSelector(swapSelector));
#endif
    
    class_addMethod(self,
                    origSelector,
                    class_getMethodImplementation(self, origSelector),
                    method_getTypeEncoding(originalMethod));
    
    class_addMethod(self,
                    swapSelector,
                    class_getMethodImplementation(self, swapSelector),
                    method_getTypeEncoding(newMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, origSelector),
                                   class_getInstanceMethod(self, swapSelector));
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
