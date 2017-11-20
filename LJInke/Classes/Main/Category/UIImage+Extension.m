//
//  UIImage+Extension.m
//  Baisibude
//
//  Created by 李军 on 2016/10/6.
//  Copyright © 2016年 lijun. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

- (instancetype)circleImage
{
    // 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 1.0);
    // 上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    // 裁剪
    CGContextClip(ctx);
    // 绘制图片
    [self drawInRect:rect];
    // 获得图片
    UIImage *currentImg = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    return currentImg;
}

@end
