//
//  NSObject+Addition.h
//  YYYTool
//
//  Created by 叶越悦 on 2017/3/2.
//  Copyright © 2017年 叶越悦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Addition)

-(NSString *)classString;
+ (void)swizzleSelector:(SEL)origSelector
           swapSelector:(SEL)swapSelector;
+ (BOOL)classMethodRespondsToSelector:(SEL)aSelector;

@end
