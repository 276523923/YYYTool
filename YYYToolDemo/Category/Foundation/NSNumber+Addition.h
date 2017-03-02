//
//  NSNumber+Addition.h
//  BaoZhangWang
//
//  Created by yyy on 16/6/12.
//  Copyright © 2016年 yyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Addition)

/**
 *  @author yyy, 16-06-12 09:22:24
 *
 *  转字符串，保留对应小数位数
 *
 *  @param digits 小数点位数
 *
 *  @return 字符串
 */
- (NSString *)stringValueWithDecimalDigits:(NSInteger)digits;

@end
