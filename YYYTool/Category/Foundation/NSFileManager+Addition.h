//
//  NSFileManager+Addition.h
//  BaoZhangWang
//
//  Created by haiyabtx on 15/7/21.
//  Copyright (c) 2015年 BaoliNetworkTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Addition)

#pragma -mark 文件属性
/**
 *  返回文件属性
 */
+ (NSDictionary *)fileAttributes:(NSString *)filePath;

+ (NSDate *)fileModificationDateWithFilePath:(NSString *)filePath;

/**
 *  返回文件大小
 */
+ (UInt64)fileSize:(NSString *)filePath;

/**
 *  返回完整路径
 */
+ (NSString *)fullPathOfFile:(NSString *)file;


#pragma -mark 加密

//文件md5加密
+ (NSString *)getMd5withFilePath:(NSString *)path;


#pragma -mark 文件操作

/**
 *  删除指定目录
 *  folderPath:相对document的folderpath 或 全路径
 */
+ (BOOL)deleteFolder:(NSString *)folderPath;

/**
 *  创建指定目录
 *  folderPath:相对document的folderpath 或 全路径
 */
+ (BOOL)createFolder:(NSString *)folderPath;

/**
 *  创建指定文件
 *  fileName:相对document的fileName 或 全路径
 *  data:文件内容
 */
+ (BOOL)createFile:(NSString *)fileName data:(NSData *)data;

/**
 *  文件是否存在
 *
 *  @param file 文件路径
 *
 *  @return 是否存在
 */
+ (BOOL)fileExist:(NSString*)file;

/**
 *	删除文件
 */
+ (BOOL)deleteFiles:(NSArray *)paths;

/**
 *	删除单个文件
 */
+ (BOOL)deleteFile:(NSString *)path;

/**
 *  复制文件到指定路径
 */
+ (BOOL)copyFrom:(NSString *)fromPath to:(NSString *)toPath;

/**
 *  移动文件
 */
+ (BOOL)moveFrom:(NSString *)fromPath to:(NSString *)toPath;

#pragma mark - 获取文件路径工具方法

/**
 *  获取documents文件夹 路径
 */
+ (NSString *)applicationDocumentsDirectory;

/**
 *  根据type 获取文件夹路径
 *  type ：NSDocumentDirectory 等类型
 */
+ (NSString *)directory:(NSSearchPathDirectory)type;

#pragma mark - 对象归档反归档
/**
 *  对象归档
 *
 *  @param object   待归档对象
 *  @param fileName 存储的文件名
 *
 *  @return 是否成功
 */
+ (BOOL)archiveObject:(id)object withFileName:(NSString *)fileName;

/**
 *  对象反归档
 *
 *  @param fileName 反归档的文件名
 *
 *  @return 反归档后的对象
 */
+ (id)unArchiveObjectWithFileName:(NSString *)fileName;

/**
 *  @author yyy, 16-03-30 15:49:54
 *
 *  删除归档文件
 *
 *  @param fileName 文件名
 *
 *  @return 是否删除成功
 */
+ (BOOL)deleateArchiveObjectWithFileName:(NSString *)fileName;

@end
