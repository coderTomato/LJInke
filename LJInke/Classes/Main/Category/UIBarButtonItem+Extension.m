//
//  UIBarButtonItem+Extension.m
//  Basi
//
//  Created by lijun on 2016/11/22.
//  Copyright © 2016年 lijun. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    UIView *containView = [[UIView alloc] initWithFrame:button.bounds];
    [containView addSubview:button];
    return [[UIBarButtonItem alloc] initWithCustomView:containView];
}

+ (instancetype)itemWithImage:(NSString *)image selectImage:(NSString *)selectImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    UIView *containView = [[UIView alloc] initWithFrame:button.bounds];
    [containView addSubview:button];
    return [[UIBarButtonItem alloc] initWithCustomView:containView];
}

+ (UIBarButtonItem *)backItemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highImage forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button sizeToFit];
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
