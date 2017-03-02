//
//  NSNumber+Addition.m
//  BaoZhangWang
//
//  Created by yyy on 16/6/12.
//  Copyright © 2016年 yyy. All rights reserved.
//

#import "NSNumber+Addition.h"

@implementation NSNumber (Addition)

- (NSString *)stringValueWithDecimalDigits:(NSInteger)digits
{
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    NSString *format = @"";
    if (digits > 0)
    {
        for (NSInteger i = 0; i < digits; i++)
        {
            format = [format stringByAppendingString:@"#"];
        }
        format = [NSString stringWithFormat:@"0.%@;",format];
    }
    else
    {
        format = @"0;";
    }
    [formatter setPositiveFormat:format];
    return [formatter stringFromNumber:self];
}

@end
