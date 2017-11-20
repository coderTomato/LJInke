//
//  NSString+Extension.m
//  Basi
//
//  Created by lijun on 2016/12/5.
//  Copyright © 2016年 lijun. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (unsigned long long)fileSize
{
    // 总大小
    unsigned long long size = 0;
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 是否为文件夹
    BOOL isDirectory = NO;
    //路径是否存在
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    if (!exists) return size;
    if (isDirectory)
    {
        NSDirectoryEnumerator *pathEnumerator = [mgr enumeratorAtPath:self];
        for (NSString *subPath in pathEnumerator)
        {
            // 全路径
            NSString *fullPath = [self stringByAppendingPathComponent:subPath];
             // 累加文件大小
            size += [mgr attributesOfItemAtPath:fullPath error:nil].fileSize;
        }
    }
    else
    {
        size = [mgr attributesOfItemAtPath:self error:nil].fileSize;
    }
    return size;
}

@end
