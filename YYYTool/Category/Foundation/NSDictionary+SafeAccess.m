//
//  NSDictionary+SafeAccess.m
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 15/1/25.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "NSDictionary+SafeAccess.h"
#import "NSObject+Addition.h"

@implementation NSDictionary (SafeAccess)
- (BOOL)hasKey:(id)key
{
    return [self objectForKey:key] != nil;
}

- (NSString*)stringForKey:(id)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]])
    {
        return value;
    }
    if ([value respondsToSelector:@selector(stringValue)])
    {
        return [value stringValue];
    }
    if ([value respondsToSelector:@selector(string)])
    {
        return [value string];
    }
    return nil;
}

- (NSNumber*)numberForKey:(id)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString*)value];
    }
    return nil;
}

- (NSDecimalNumber *)decimalNumberForKey:(id)key {
    id value = [self objectForKey:key];
    
    if ([value isKindOfClass:[NSDecimalNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber * number = (NSNumber*)value;
        return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
    } else if ([value isKindOfClass:[NSString class]]) {
        NSString * str = (NSString*)value;
        return [str isEqualToString:@""] ? nil : [NSDecimalNumber decimalNumberWithString:str];
    }
    return nil;
}


- (NSArray*)arrayForKey:(id)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]])
    {
        return value;
    }
    return nil;
}

- (NSDictionary*)dictionaryForKey:(id)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]])
    {
        return value;
    }
    return nil;
}

- (NSInteger)integerForKey:(id)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value integerValue];
    }
    return 0;
}
- (NSUInteger)unsignedIntegerForKey:(id)key{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value unsignedIntegerValue];
    }
    return 0;
}
- (BOOL)boolForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value boolValue];
    }
    return NO;
}
- (int16_t)int16ForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (int32_t)int32ForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (int64_t)int64ForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value longLongValue];
    }
    return 0;
}
- (char)charForKey:(id)key{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value charValue];
    }
    return 0;
}
- (short)shortForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (float)floatForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value floatValue];
    }
    return 0;
}
- (double)doubleForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value doubleValue];
    }
    return 0;
}
- (long long)longLongForKey:(id)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value longLongValue];
    }
    return 0;
}

- (unsigned long long)unsignedLongLongForKey:(id)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        value = [nf numberFromString:value];
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedLongLongValue];
    }
    return 0;
}

- (NSDate *)dateForKey:(id)key dateFormat:(NSString *)dateFormat{
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = dateFormat;
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    
    if ([value isKindOfClass:[NSString class]] && ![value isEqualToString:@""] && !dateFormat) {
        return [formater dateFromString:value];
    }
    return nil;
}


//CG
- (CGFloat)CGFloatForKey:(id)key
{
    return [self doubleForKey:key];
}

- (CGPoint)pointForKey:(id)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSValue class]])
    {
        return [value CGPointValue];
    }
    else if ([value isKindOfClass:[NSString class]])
    {
        return CGPointFromString(value);
    }
    return CGPointZero;
}
- (CGSize)sizeForKey:(id)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSValue class]])
    {
        return [value CGSizeValue];
    }
    else if ([value isKindOfClass:[NSString class]])
    {
        return CGSizeFromString(value);
    }
    return CGSizeZero;

}
- (CGRect)rectForKey:(id)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSValue class]])
    {
        return [value CGRectValue];
    }
    else if ([value isKindOfClass:[NSString class]])
    {
        return CGRectFromString(value);
    }
    return CGRectNull;
}
@end

#pragma --mark NSMutableDictionary setter
@implementation NSMutableDictionary (SafeAccess)
-(void)setObj:(id)i forKey:(NSString*)key{
    if (!key) {
        return;
    }
    if (i)
    {
        [self setObject:i forKey:key];
    }
    else
    {
        [self removeObjectForKey:key];
    }
}
-(void)setString:(NSString*)i forKey:(NSString*)key;
{
    if (i == nil || ![i isKindOfClass:[NSString class]]) {
        [self removeObjectForKey:key];
    }
    else
    {
        [self setValue:i forKey:key];
    }
}
-(void)setBool:(BOOL)i forKey:(NSString *)key
{
    [self setObj:@(i) forKey:key];
}
-(void)setInt:(int)i forKey:(NSString *)key
{
    [self setObj:@(i) forKey:key];
}
-(void)setInteger:(NSInteger)i forKey:(NSString *)key
{
    [self setObj:@(i) forKey:key];
}
-(void)setUnsignedInteger:(NSUInteger)i forKey:(NSString *)key
{
    [self setObj:@(i) forKey:key];
}
-(void)setCGFloat:(CGFloat)f forKey:(NSString *)key
{
    [self setObj:@(f) forKey:key];
}
-(void)setChar:(char)c forKey:(NSString *)key
{
    [self setObj:@(c) forKey:key];
}
-(void)setFloat:(float)i forKey:(NSString *)key
{
    [self setObj:@(i) forKey:key];
}
-(void)setDouble:(double)i forKey:(NSString*)key{
    [self setObj:@(i) forKey:key];
}
-(void)setLongLong:(long long)i forKey:(NSString*)key{
    [self setObj:@(i) forKey:key];
}
-(void)setPoint:(CGPoint)o forKey:(NSString *)key
{
    [self setObj:[NSValue valueWithCGPoint:o] forKey:key];
}
-(void)setSize:(CGSize)o forKey:(NSString *)key
{
    [self setObj:[NSValue valueWithCGSize:o] forKey:key];
}
-(void)setRect:(CGRect)o forKey:(NSString *)key
{
    [self setObj:[NSValue valueWithCGRect:o] forKey:key];
}
@end
