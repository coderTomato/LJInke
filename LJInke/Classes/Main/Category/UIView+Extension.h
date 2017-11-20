//
//  UIView+Extension.h
//  Basi
//
//  Created by lijun on 2016/11/21.
//  Copyright © 2016年 lijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

/** <#注释#>*/
@property (assign, nonatomic) CGFloat ty_x;
/** <#注释#>*/
@property (assign, nonatomic) CGFloat ty_y;
/** */
@property (assign, nonatomic) CGSize ty_size;
/** <#注释#>*/
@property (assign, nonatomic) CGFloat ty_width;
/** <#注释#>*/
@property (assign, nonatomic) CGFloat ty_height;
/** <#注释#>*/
@property (assign, nonatomic) CGFloat ty_centerX;
/** <#注释#>*/
@property (assign, nonatomic) CGFloat ty_centerY;
/** <#注释#>*/
@property (assign, nonatomic) CGFloat ty_right;
/** <#注释#>*/
@property (assign, nonatomic) CGFloat ty_bottom;

+ (instancetype)viewFromXib;
- (BOOL)intersectWithView:(UIView *)view;
/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;
/**
 * The view controller whose view contains this view.
 */
- (UIViewController*)viewController;
/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowInKeyWindow;

@end
