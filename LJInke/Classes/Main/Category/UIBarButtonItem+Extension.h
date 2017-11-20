//
//  UIBarButtonItem+Extension.h
//  Basi
//
//  Created by lijun on 2016/11/22.
//  Copyright © 2016年 lijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

+ (instancetype)itemWithImage:(NSString *)image selectImage:(NSString *)selectImage target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)backItemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title;

@end
