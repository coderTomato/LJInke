//
//  UITextField+Extension.h
//  Basi
//
//  Created by lijun on 2016/12/4.
//  Copyright © 2016年 lijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)

/** 占位文字颜色*/
@property (strong, nonatomic) UIColor *placeholderColor;

- (void)setTY_placeholder:(NSString *)placeholder;

@end
