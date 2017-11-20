//
//  UITextField+Extension.m
//  Basi
//
//  Created by lijun on 2016/12/4.
//  Copyright © 2016年 lijun. All rights reserved.
//

#import "UITextField+Extension.h"
#import <objc/message.h>

@implementation UITextField (Extension)

+ (void)load
{
    Method placeHolderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method ty_placeHolerMethod = class_getInstanceMethod(self, @selector(setTY_placeholder:));
    method_exchangeImplementations(placeHolderMethod, ty_placeHolerMethod);
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    // 给成员属性赋值 runtime给系统的类添加成员属性
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // 获取占位文字label控件
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    // 设置占位文字颜色
    placeholderLabel.textColor = placeholderColor;
    if (!placeholderColor) {
        placeholderLabel.textColor = [UIColor grayColor];
    }
}

- (UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, @"placeholderColor");
}

- (void)setTY_placeholder:(NSString *)placeholder
{
    [self setTY_placeholder:placeholder];
    self.placeholderColor = self.placeholderColor;
}

@end
