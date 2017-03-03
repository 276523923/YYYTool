//
//  NSFileManager+Addition.m
//  BaoZhangWang
//
//  Created by haiyabtx on 15/7/21.
//  Copyright (c) 2015年 BaoliNetworkTechnology. All rights reserved.
//

#import "NSFileManager+Addition.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSFileManager (Addition)

/*
 *  返回文件属性
 */
+ (NSDictionary *)fileAttributes:(NSString *)filePath
{
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    return dic;
}

+ (NSDate *)fileModificationDateWithFilePath:(NSString *)filePath
{
    NSDictionary *dic = [self fileAttributes:filePath];
    if (!dic)
    {
        return nil;
    }
    else
    {
        return [dic fileModificationDate];
    }
}

/*
 *  返回文件大小
 */
+ (UInt64)fileSize:(NSString *)filePath
{
    NSDictionary *dic = [self fileAttributes:filePath];
    if (dic == nil) {
        return 0;
    }
    UInt64 fileSize = [dic[NSFileSize] unsignedLongLongValue];
    
    return fileSize;
}

/*
 *  返回完整路径
 */
+ (NSString *)fullPathOfFile:(NSString *)file
{
    if ([file isAbsolutePath]) {
        return file;
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = paths[0];//需要的路径
    return [directory stringByAppendingPathComponent:file];
}

//文件md5加密
+ (NSString *)getMd5withFilePath:(NSString *)path
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    if( handle== nil ) {
        return nil;
    }
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    BOOL done = NO;
    while(!done)
    {
        @autoreleasepool {
            NSData* fileData = [handle readDataOfLength:16*1024];
            CC_MD5_Update(&md5, [fileData bytes], (uint32_t)[fileData length]);
            if( [fileData length] == 0 ) done = YES;
        }
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString *MD5 = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                     digest[0], digest[1],
                     digest[2], digest[3],
                     digest[4], digest[5],
                     digest[6], digest[7],
                     digest[8], digest[9],
                     digest[10], digest[11],
                     digest[12], digest[13],
                     digest[14], digest[15]];
    [handle closeFile];
    handle = nil;
    return MD5;
}

/*
 *  删除指定目录
 *  folderPath:相对document的folderpath 或 全路径
 */
+ (BOOL)deleteFolder:(NSString *)folderPath
{
    //创建文件管理器
    NSFileManager *fileManage = [NSFileManager defaultManager];
    
    //参数NSDocumentDirectory要获取那种路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *directory = paths[0];//需要的路径
    
    //更改到待操作的目录下
    [fileManage changeCurrentDirectoryPath:directory];
    
    NSError *error = nil;
    //文件夹是否存在
    if (![fileManage fileExistsAtPath:folderPath])
    {
        NSLog(@"folder no exist :%@", folderPath);
        return YES;
    }
    //删除文件夹
    if (![fileManage removeItemAtPath:folderPath error:&error])
    {
        NSLog(@"folderpath：[%@] error：[%@]", folderPath, error);
        return FALSE;
    }
    return true;
}

/*
 *  创建指定目录
 *  folderPath:相对document的folderpath 或 全路径
 */
+ (BOOL)createFolder:(NSString *)folderPath
{
    BOOL isDir = NO;
    BOOL isExist = NO;
    NSError *error = nil;
    
    //创建文件管理器
    NSFileManager *fileManage = [NSFileManager defaultManager];
    
    //参数NSDocumentDirectory要获取那种路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *directory = paths[0];//需要的路径
    
    //更改到待操作的目录下
    [fileManage changeCurrentDirectoryPath:directory];
    
    isExist = [fileManage fileExistsAtPath:folderPath isDirectory:&isDir];
    
    //文件夹是否存在
    if (!isDir || !isExist)
    {
        //创建文件夹
        if (![fileManage createDirectoryAtPath:folderPath withIntermediateDirectories:YES
                                    attributes:nil error:&error])
        {
            NSLog(@"Can not create directory %@.  Error is %@.", folderPath, error);
            return FALSE;
        }
    }
    return true;
}

/*
 *  创建指定文件
 *  fileName:相对document的fileName 或 全路径
 *  data:文件内容
 */
+ (BOOL)createFile:(NSString *)fileName data:(NSData *)data
{
    //创建文件管理器
    NSFileManager *fileManage = [NSFileManager defaultManager];
    
    //参数NSDocumentDirectory要获取那种路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *directory = paths[0];//需要的路径
    
    //更改到待操作的目录下
    [fileManage changeCurrentDirectoryPath:directory];
    
    if (![fileManage fileExistsAtPath:fileName])
    {
        //创建文件夹
        if (![fileManage createFileAtPath:fileName contents:data attributes:nil])
        {
            NSLog(@"Can not create file %@.", fileName);
            return FALSE;
        }
    }
    return true;
}

//文件是否存在
+ (BOOL)fileExist:(NSString*)file
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:file];
}

/*
 *	删除单个文件
 */
+ (BOOL)deleteFile:(NSString *)path
{
    //创建文件管理器
    NSFileManager *fm = [NSFileManager defaultManager];
    //操作结果
    NSError *error = nil;
    
    if([fm fileExistsAtPath:path] == FALSE)//文件不存在
    {
        return YES;
    }
    if([fm removeItemAtPath:path error:&error] == NO)//文件删除失败
    {
        NSLog(@"path:[%@]，reason：[%d][%@]", path, (int)[error code], [error domain]);
        return FALSE;
    }
    return TRUE;
}

/*
 *	删除文件
 */
+ (BOOL)deleteFiles:(NSArray *)paths
{
    //创建文件管理器
    NSFileManager *fm = [NSFileManager defaultManager];
    //操作结果
    NSError *error = nil;
    
    //循环根据具体的路径删除文件
    for(NSString *path in paths)
    {
        if([fm fileExistsAtPath:path] == FALSE)//文件不存在
        {
            continue;
        }
        if([fm removeItemAtPath:path error:&error] == NO)//文件删除失败
        {
            NSLog(@"path:[%@]，reason：[%d][%@]", path, (int)[error code], [error domain]);
            return FALSE;
        }
    }
    
    return TRUE;
}

+ (BOOL)copyFrom:(NSString *)fromPath to:(NSString *)toPath
{
    //创建文件管理器
    NSFileManager *fm = [NSFileManager defaultManager];
    //操作结果
    NSError *err = nil;
    
    if (![fm copyItemAtPath:fromPath toPath:toPath error:&err])
    {
        NSLog(@"path:[%@],reason:[%d][%@]]", fromPath,(int)[err code],[err domain]);
        return FALSE;
    }
    return YES;
}

+ (BOOL)moveFrom:(NSString *)fromPath to:(NSString *)toPath
{
    //创建文件管理器
    NSFileManager *fm = [NSFileManager defaultManager];
    //操作结果
    NSError *err = nil;
    
    if (![fm moveItemAtPath:fromPath toPath:toPath error:&err])
    {
        NSLog(@"path:[%@],reason:[%d][%@]]", fromPath,(int)[err code],[err domain]);
        return FALSE;
    }
    return YES;
}

#pragma mark - 获取文件路径工具方法

/*
 *  获取documents文件夹 路径
 */
+ (NSString *)applicationDocumentsDirectory
{
    return [[self directory:NSDocumentDirectory] stringByAppendingString:@"/"];
}

/*
 *  根据type 获取文件夹路径
 *  type ：NSDocumentDirectory 等类型
 */
+ (NSString *)directory:(NSSearchPathDirectory)type
{
    NSArray *array = NSSearchPathForDirectoriesInDomains(type, NSUserDomainMask, YES);
    return array.count > 0 ? array[0]:nil;
}

#pragma mark - 对象归档反归档
+ (BOOL)archiveObject:(id)object withFileName:(NSString *)fileName
{
    NSAssert(object, @"不能归档空对象！");
    NSString *filePath = [[NSFileManager applicationDocumentsDirectory] stringByAppendingPathComponent:fileName];
    return [NSKeyedArchiver archiveRootObject:object toFile:filePath];
}

+ (id)unArchiveObjectWithFileName:(NSString *)fileName
{
    NSString *filePath = [[NSFileManager applicationDocumentsDirectory] stringByAppendingPathComponent:fileName];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

+ (BOOL)deleateArchiveObjectWithFileName:(NSString *)fileName
{
    NSString *filePath = [[NSFileManager applicationDocumentsDirectory] stringByAppendingPathComponent:fileName];
    return [NSFileManager deleteFile:filePath];
}

@end
