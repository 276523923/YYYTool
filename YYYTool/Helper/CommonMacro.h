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
 Synthsize a weak or strong reference.
 
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 
 */
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) @autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) @autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) @try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) @try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) @autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) @autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) @try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) @try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif


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
#define weakify_self weakify(self);
#endif

#ifndef strongify_self
#define strongify_self strongify(self);
#endif


#define OBJC_REQUIRES_SUPER  __attribute__((objc_requires_super))

/**
 * HEXA 美工给的颜色转换成程序的颜色
 */
#define colorWithHEXA(hex,a) (UIColor colorWithHexString:hex alpha:a])

/**
 * 设备屏幕大小,含状态栏
 */
#ifndef kDeviceBoundsSize
#define kDeviceBoundsSize [[UIScreen mainScreen] bounds].size
#endif

#ifndef kDeviceBoundsHeight
#define kDeviceBoundsHeight [[UIScreen mainScreen] bounds].size.height
#endif

#ifndef kDeviceBoundsWidth
#define kDeviceBoundsWidth [[UIScreen mainScreen] bounds].size.width
#endif

#define iPhone6RatioForWidth(value) kDeviceBoundsWidth / 375.f * value

#ifndef kStatushHeight
#define kStatushHeight YYYStatushBarHeight()
#endif

#ifndef kTabbarHeight
#define kTabbarHeight YYYTabbarHeight()
#endif

#ifndef kNavigationBarHeight
#define kNavigationBarHeight 44
#endif

#if DEBUG
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
