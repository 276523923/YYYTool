//
//  UtilMethod.m
//  BaoZhangWang
//
//  Created by yyy on 16/7/20.
//  Copyright © 2016年 yyy. All rights reserved.
//

#import "UtilMethod.h"
#import <objc/message.h>
#import "NSDate+Addition.h"
#import "UIDevice+Addition.h"
#import <sys/time.h>

BOOL IsEmptyObj(id obj){
    if (obj == nil)
    {
        return YES;
    }
    else if ([obj isEqual:[NSNull null]])
    {
        return YES;
    }
    else if ([obj isKindOfClass:[NSString class]] && ([(NSString *)obj length] == 0))
    {
        return YES;
    }
    else if ([obj isKindOfClass:[NSArray class]] && ([(NSArray *)obj count] == 0))
    {
        return YES;
    }
    else if ([obj isKindOfClass:[NSDictionary class]] && ([(NSDictionary *)obj count] == 0))
    {
        return YES;
    }
    return NO;
}

BOOL NoEmptyObj(id obj){
    return !IsEmptyObj(obj);
}

id DefaultObj(id obj,id defaultValue){
    if (obj == nil) {
        return defaultValue;
    }
    if (defaultValue == nil) {
        return obj;
    }
    Class cls ;
    if ([defaultValue isKindOfClass:[NSString class]])
    {
        cls = [NSString class];
    }
    else if ([defaultValue isKindOfClass:[NSArray class]])
    {
        cls = [NSArray class];
    }
    else if ([defaultValue isKindOfClass:[NSDictionary class]])
    {
        cls = [NSDictionary class];
    }
    else if ([defaultValue isKindOfClass:[NSNumber class]])
    {
        cls = [NSNumber class];
    }
    else
    {
        cls = [defaultValue class];
    }
    if (![obj isKindOfClass:cls])
    {
        return defaultValue;
    }
    return IsEmptyObj(obj)? defaultValue:obj;
}

__attribute((overloadable)) NSString *StringObj(id obj){
    return  StringObj(obj, @"");
}

__attribute((overloadable)) NSString *StringObj(id obj,NSString *defaultString){
    if (!defaultString || ![defaultString isKindOfClass:[NSString class]])
    {
        defaultString = @"";
    }
    if (IsEmptyObj(obj))
    {
        return defaultString;
    }
    if ([obj isKindOfClass:[NSString class]])
    {
        return obj;
    }
    if ([obj isKindOfClass:[NSNumber class]])
    {
        return [obj stringValue];
    }
    if ([obj isKindOfClass:[NSData class]])
    {
        return StringObj([[NSString alloc]initWithData:obj encoding:NSUTF8StringEncoding]);
    }
    if ([obj isKindOfClass:[NSDate class]])
    {
        return [obj stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    if ([obj respondsToSelector:@selector(string)])
    {
        return [obj string];
    }
    if ([obj respondsToSelector:@selector(stringValue)])
    {
        return [obj stringValue];
    }
    return defaultString;
}

NSString *StringNum(id obj){
    if (obj == nil) {
        return @"0";
    }
    if ([obj isKindOfClass:[NSNumber class]])
    {
        return [obj stringValue];
    }
    return @"0";
}

BOOL BOOLValue(id obj){
    if (IsEmptyObj(obj))
    {
        return NO;
    }
    if ([obj isKindOfClass:[NSNumber class]])
    {
        return [obj boolValue];
    }
    if ([obj isKindOfClass:[NSString class]])
    {
        NSString *string = [obj lowercaseString];
        if ([string isEqualToString:@"yes"] ||
            [string isEqualToString:@"true"] ||
            [string isEqualToString:@"1"])
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return NO;
}

void YYYBenchmark(void (^block)(void), void (^complete)(double ms)) {
    struct timeval t0, t1;
    gettimeofday(&t0, NULL);
    block();
    gettimeofday(&t1, NULL);
    double ms = (double)(t1.tv_sec - t0.tv_sec) * 1e3 + (double)(t1.tv_usec - t0.tv_usec) * 1e-3;
    complete(ms);
}
