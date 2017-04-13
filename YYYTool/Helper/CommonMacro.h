//
//  CommonMacro.h
//  BaoZhangWangiPad
//
//  Created by yyy on 15/12/14.
//  Copyright © 2015年 yyy. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h


/**
 * 强弱引用转换，用于解决代码块（block）与强引用self之间的循环引用问题
 * 调用方式: `weakify_self`实现弱引用转换，`strongify_self`实现强引用转换
 *
 * 示例：
 * weakify_self
 * [obj block:^{
 * strongify_self
 * self.property = something;
 * }];
 */
#ifndef weakify_self
#if __has_feature(objc_arc)
#define weakify_self @autoreleasepool{} __weak __typeof__(self) weakSelf_ = self;
#else
#define weakify_self @autoreleasepool{} __block __typeof__(self) blockSelf_ = self;
#endif
#endif

#ifndef strongify_self
#if __has_feature(objc_arc)
#define strongify_self @try{} @finally{} __strong __typeof__(weakSelf_) self = weakSelf_;
#else
#define strongify_self @try{} @finally{} __typeof__(blockSelf_) self = blockSelf_;
#endif
#endif


#define OBJC_REQUIRES_SUPER  __attribute__((objc_requires_super))

/**
 * ios10以上编译
 */
#define ios10AndUper SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10")

/**
 * ios9以上编译
 */
#define ios9AndUper SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9")

/**
 * ios8以上编译
 */
#define ios8AndUper SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8")

/**
 * ios7以上编译
 */
#define ios7AndUper SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7")

/**
 * sdk7及以上编译
 */
#define SDK7AndUper (__IPHONE_OS_VERSION_MAX_ALLOWED >= 70000)

/**
 *sdk8以上编译
 */
#define SDK8AndUper (__IPHONE_OS_VERSION_MAX_ALLOWED >= 80000)

/**
 *  方法宏定义
 */
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


/**
 * HEX 美工给的颜色转换成程序的颜色
 */
#define colorWithHEX(hex) ([UIColor colorWithHexString:hex])

/**
 * HEXA 美工给的颜色转换成程序的颜色
 */
#define colorWithHEXA(hex,a) (UIColor colorWithHexString:hex alpha:a])

/**
 * 美工给的字体像素高度转换成对应系统字体
 */
#define systemFontWithPx(f) [UIFont systemFontOfSize:(f-2)/2]

/**
 * 设置字体大小
 */
//#define FONT(size)    [UIFont systemFontOfSize:iPhone6P?size+1:size]
//#define BOLDFONT(size) [UIFont boldSystemFontOfSize:iPhone6P?size+1:size]

/**
 *  (320, 480)的屏幕
 */
#define iPhone3 CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size)
/**
 *  (640, 960)的屏幕
 */
#define iPhone4 CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size)
/**
 *  (640, 1136)的屏幕·
 */
#define iPhone5 CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)
/**
 *  (750, 1334)的屏幕
 */
#define iPhone6 CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)
/**
 *  (1242, 2208)的屏幕
 */
#define iPhone6P CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)

//iphone6及以上手机
#define iphone6AndUper ([[UIScreen mainScreen] currentMode].size.width > 640)

/**
 * 设备屏幕大小,含状态栏
 */
#define kDeviceBoundsSize [[UIScreen mainScreen] bounds].size
#define kDeviceBoundsHeight [[UIScreen mainScreen] bounds].size.height
#define kDeviceBoundsWidth [[UIScreen mainScreen] bounds].size.width

#define iPhone6RatioForWidth(value) kDeviceBoundsWidth / 375.f * value

#define kStatushHeight 20
#define kTabbarHeight 49

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
#define NSLog(...)
#endif

/**
 *  宏定义检测Block是否可用
 *
 *  @param block 要检测的block
 *  @param ...   要传的值
 */
#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };



/**
 * RGB 美工给的颜色转换成程序的颜色
 */
#define RGB(r, g, b) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0])

/**
 * RGBA 美工给的颜色转换成程序的颜色
 */
#define RGBA(r, g, b, a) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])


#endif /* CommonMacro_h */
