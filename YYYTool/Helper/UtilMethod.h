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
/**
 判断是否为空对象,NSNull,NSArray count = 0,NSDictionary count = 0,NSString length = 0,都为空
 */
extern BOOL IsEmptyObj(id obj);

extern BOOL NoEmptyObj(id obj);

/**
 判断是否为非空数组，只有对象为数组，且 count > 0 ，才返回YES
 */
BOOL NotEmptyArray(id array);

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

/**
 obj 转布尔值
 */
extern BOOL BOOLValue(id obj);


extern UIFont *FONT(CGFloat size);
extern UIFont *BOLDFONT(CGFloat size);


#endif /* UtilMethod_h */
