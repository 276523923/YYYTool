//
//  NSOrderedSet+YYYAddition.m
//  Pods
//
//  Created by 叶越悦 on 2017/6/21.
//
//

#import "NSOrderedSet+YYYAddition.h"

@implementation NSOrderedSet (YYYAddition)

-(id)objAtIndex:(NSUInteger)index
{
    if (index <self.count) {
        return [self objectAtIndex:index];
    }
    else
    {
        return nil;
    }
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    id value = [self objAtIndex:indexPath.section];
    if (value && ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSOrderedSet class]]))
    {
        if ([value respondsToSelector:@selector(objAtIndex:)])
        {
            return [value objAtIndex:indexPath.row];
        }
        else
        {
            if (indexPath.row < [value count])
            {
                return [value objectAtIndex:indexPath.row];
            }
            return nil;
        }
    }
    else
    {
        return nil;
    }
}

- (NSString*)stringWithIndex:(NSUInteger)index
{
    id value = [self objAtIndex:index];
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

- (NSNumber*)numberWithIndex:(NSUInteger)index
{
    id value = [self objAtIndex:index];
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

- (NSDecimalNumber *)decimalNumberWithIndex:(NSUInteger)index{
    id value = [self objAtIndex:index];
    
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

- (NSArray*)arrayWithIndex:(NSUInteger)index
{
    id value = [self objAtIndex:index];
    if ([value isKindOfClass:[NSArray class]])
    {
        return value;
    }
    return nil;
}


- (NSDictionary*)dictionaryWithIndex:(NSUInteger)index
{
    id value = [self objAtIndex:index];
    if ([value isKindOfClass:[NSDictionary class]])
    {
        return value;
    }
    return nil;
}

- (NSInteger)integerWithIndex:(NSUInteger)index
{
    id value = [self objAtIndex:index];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value integerValue];
    }
    return 0;
}
- (NSUInteger)unsignedIntegerWithIndex:(NSUInteger)index
{
    id value = [self objAtIndex:index];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value unsignedIntegerValue];
    }
    return 0;
}
- (BOOL)boolWithIndex:(NSUInteger)index
{
    id value = [self objAtIndex:index];
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
- (int16_t)int16WithIndex:(NSUInteger)index
{
    id value = [self objAtIndex:index];
    
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
- (int32_t)int32WithIndex:(NSUInteger)index
{
    id value = [self objAtIndex:index];
    
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
- (int64_t)int64WithIndex:(NSUInteger)index
{
    id value = [self objAtIndex:index];
    
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

- (char)charWithIndex:(NSUInteger)index{
    
    id value = [self objAtIndex:index];
    
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

- (short)shortWithIndex:(NSUInteger)index
{
    id value = [self objAtIndex:index];
    
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
- (float)floatWithIndex:(NSUInteger)index
{
    id value = [self objAtIndex:index];
    
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
- (double)doubleWithIndex:(NSUInteger)index
{
    id value = [self objAtIndex:index];
    
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

- (NSDate *)dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = dateFormat;
    id value = [self objAtIndex:index];
    
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
- (CGFloat)CGFloatWithIndex:(NSUInteger)index
{
    return [[self numberWithIndex:index] doubleValue];
}

- (CGPoint)pointWithIndex:(NSUInteger)index
{
    id value = [self objAtIndex:index];
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

- (CGSize)sizeWithIndex:(NSUInteger)index
{
    id value = [self objAtIndex:index];
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
- (CGRect)rectWithIndex:(NSUInteger)index
{
    id value = [self objAtIndex:index];
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

@implementation NSMutableOrderedSet (YYYAddition)

-(void)addObj:(id)i
{
    if (i!=nil)
    {
        [self addObject:i];
    }
}
-(void)addString:(NSString*)i
{
    if (i!=nil)
    {
        [self addObject:i];
    }
}
-(void)addBool:(BOOL)i
{
    [self addObject:@(i)];
}
-(void)addInt:(int)i
{
    [self addObject:@(i)];
}
-(void)addInteger:(NSInteger)i
{
    [self addObject:@(i)];
}
-(void)addUnsignedInteger:(NSUInteger)i
{
    [self addObject:@(i)];
}
-(void)addCGFloat:(CGFloat)f
{
    [self addObject:@(f)];
}
-(void)addChar:(char)c
{
    [self addObject:@(c)];
}
-(void)addFloat:(float)i
{
    [self addObject:@(i)];
}
-(void)addPoint:(CGPoint)o
{
    [self addObj:[NSValue valueWithCGPoint:o]];
}
-(void)addSize:(CGSize)o
{
    [self addObj:[NSValue valueWithCGSize:o]];
}
-(void)addRect:(CGRect)o
{
    [self addObj:[NSValue valueWithCGRect:o]];
}

@end
