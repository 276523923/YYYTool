//
//  UtilMethod.h
//  BZWDecorationDiary
//
//  Created by yyy on 16/5/18.
//  Copyright © 2016年 yyy. All rights reserved.
//

#ifndef UtilMethod_h
#define UtilMethod_h
#import <UIKit/UIKit.h>
#import "UIDevice+Addition.h"

typedef NS_ENUM(NSUInteger, iPhoneModel) {
    kiPhoneModel_3,
    kiPhoneModel_4,
    kiPhoneModel_5,
    kiPhoneModel_6,
    kiPhoneModel_6P,
};

static inline iPhoneModel YYYiPhoneModel(){
    static iPhoneModel iPhoneModelValue = kiPhoneModel_6;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGSize size = [[UIScreen mainScreen] currentMode].size;
        if (CGSizeEqualToSize(CGSizeMake(320, 480),size))
        {
            iPhoneModelValue = kiPhoneModel_3;
        }
        else if (CGSizeEqualToSize(CGSizeMake(640, 960),size))
        {
            iPhoneModelValue = kiPhoneModel_4;
        }
        else if (CGSizeEqualToSize(CGSizeMake(640, 1136),size))
        {
            iPhoneModelValue = kiPhoneModel_5;
        }
        else if (CGSizeEqualToSize(CGSizeMake(750, 1334),size))
        {
            iPhoneModelValue = kiPhoneModel_6;
        }
        else if (CGSizeEqualToSize(CGSizeMake(1242, 2208),size))
        {
            iPhoneModelValue = kiPhoneModel_6P;
        }
        else
        {
            iPhoneModelValue = kiPhoneModel_6;//默认6吧。
        }
    });
    return iPhoneModelValue;
}

/**
 *  (320, 480)的屏幕
 */
static inline BOOL YYYiPhone3(){
    return YYYiPhoneModel() == kiPhoneModel_3;
}
/**
 *  (640, 960)的屏幕
 */
static inline BOOL YYYiPhone4(){
    return YYYiPhoneModel() == kiPhoneModel_4;
}
/**
 *  (640, 1136)的屏幕·
 */
static inline BOOL YYYiPhone5(){
    return YYYiPhoneModel() == kiPhoneModel_5;
}
/**
 *  (750, 1334)的屏幕
 */
static inline BOOL YYYiPhone6(){
    return YYYiPhoneModel() == kiPhoneModel_6;
}
/**
 *  (1242, 2208)的屏幕
 */
static inline BOOL YYYiPhone6P(){
    return YYYiPhoneModel() == kiPhoneModel_6P;
}
//iphone6及以上手机
static inline BOOL YYYiphone6AndUper(){
    return YYYiPhoneModel() >= kiPhoneModel_6;
}

#define iPhone3 YYYiPhone3()
#define iPhone4 YYYiPhone4()
#define iPhone5 YYYiPhone5()
#define iPhone6 YYYiPhone6()
#define iPhone6P YYYiPhone6P()
#define iphone6AndUper YYYiphone6AndUper()

/**
 判断是否为空对象,NSNull,NSArray count = 0,NSDictionary count = 0,NSString length = 0,都为空
 */
extern BOOL IsEmptyObj(id obj);

extern BOOL NoEmptyObj(id obj);

/**
 判断是否为非空数组，只有对象为数组，且 count > 0 ，才返回YES
 */
static inline BOOL NotEmptyArray(id array)
{
    if ([array isKindOfClass:NSArray.class] && [(NSArray *)array count] > 0)
    {
        return YES;
    }
    return NO;
}

/**
 如果obj为空，则返回defaultValue
 */
extern id DefaultObj(id obj,id defaultValue);

/**
 对象字符串化，为空则返回 @“”
 */
extern __attribute((overloadable)) NSString *StringObj(id obj);

/**
 对象字符串化，为空对象则返回 defaultString
 */
extern __attribute((overloadable)) NSString *StringObj(id obj,NSString *defaultString);

extern NSString *StringNum(id obj);

/**
 obj 转布尔值
 */
extern BOOL BOOLValue(id obj);

extern void YYYBenchmark(void (^block)(void), void (^complete)(double ms));

__attribute((overloadable)) static inline CGFloat iPhoneFloatValue(CGFloat iP5,CGFloat iP6,CGFloat iP6P){
    switch (YYYiPhoneModel())
    {
        case kiPhoneModel_5:
            return iP5;
        case kiPhoneModel_6:
            return iP6;
        case kiPhoneModel_6P:
            return iP6P;
        default:
            return iP6;
    }
}

__attribute((overloadable)) static inline CGFloat iPhoneFloatValue(CGFloat iP5,CGFloat iPhone6UpValue){
    return iPhoneFloatValue(iP5, iPhone6UpValue, iPhone6UpValue);
}

static inline id iPhoneIDValue(id iP5,id iP6,id iP6P){
    switch (YYYiPhoneModel())
    {
        case kiPhoneModel_5:
            return iP5;
        case kiPhoneModel_6:
            return iP6;
        case kiPhoneModel_6P:
            return iP6P;
        default:
            return iP6;
    }
}

static inline UIFont *FONT(CGFloat size){
    return [UIFont systemFontOfSize:iPhone6P?size+1:size];
}

static inline UIFont *BOLDFONT(CGFloat size){
    return [UIFont boldSystemFontOfSize:iPhone6P?size+1:size];
}

static inline UIFont *LIGHTFONT(CGFloat size){
    static BOOL hasLightFont = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Light" size:10];
        if (font) {
            hasLightFont = YES;
        }
    });
    return hasLightFont? [UIFont fontWithName:@"PingFangSC-Light" size:iPhone6P?size+1:size]:FONT(size);
}

static inline UIFont *REGULARFONT(CGFloat size){
    static BOOL hasRegularFont = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
        if (font) {
            hasRegularFont = YES;
        }
    });
    return hasRegularFont?[UIFont fontWithName:@"PingFangSC-Regular" size:iPhone6P?size+1:size]:FONT(size);
}

/**
 Submits a block for asynchronous execution on a main queue and returns immediately.
 */
static inline void dispatch_async_on_main_queue(void (^block)()) {
    dispatch_async(dispatch_get_main_queue(), block);
}

/**
 Submits a block for execution on a main queue and waits until the block completes.
 */
static inline void dispatch_sync_on_main_queue(void (^block)()) {
    dispatch_sync(dispatch_get_main_queue(), block);
}



#endif /* UtilMethod_h */
