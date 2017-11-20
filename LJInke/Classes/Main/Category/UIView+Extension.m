//
//  UIView+Extension.m
//  Basi
//
//  Created by lijun on 2016/11/21.
//  Copyright © 2016年 lijun. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setTy_x:(CGFloat)ty_x
{
    CGRect frame = self.frame;
    frame.origin.x = ty_x;
    self.frame = frame;
}

- (CGFloat)ty_x
{
    return self.frame.origin.x;
}

- (void)setTy_y:(CGFloat)ty_y
{
    CGRect frame = self.frame;
    frame.origin.y = ty_y;
    self.frame = frame;
}

- (CGFloat)ty_y
{
    return self.frame.origin.y;
}

- (void)setTy_size:(CGSize)ty_size
{
    CGRect frame = self.frame;
    frame.size = ty_size;
    self.frame = frame;
}

- (CGSize)ty_size
{
    return self.frame.size;
}

- (void)setTy_width:(CGFloat)ty_width
{
    CGRect frame = self.frame;
    frame.size.width = ty_width;
    self.frame = frame;
}

- (CGFloat)ty_width
{
    return self.frame.size.width;
}

- (void)setTy_height:(CGFloat)ty_height
{
    CGRect frame = self.frame;
    frame.size.height = ty_height;
    self.frame = frame;
}

- (CGFloat)ty_height
{
    return self.frame.size.height;
}

- (void)setTy_centerX:(CGFloat)ty_centerX
{
    CGPoint center = self.center;
    center.x = ty_centerX;
    self.center = center;
}

- (CGFloat)ty_centerX
{
    return self.center.x;
}

- (void)setTy_centerY:(CGFloat)ty_centerY
{
    CGPoint center = self.center;
    center.y = ty_centerY;
    self.center = center;
}

- (CGFloat)ty_centerY
{
    return self.center.y;
}

- (void)setTy_right:(CGFloat)ty_right
{
    CGRect frame = self.frame;
    frame.origin.x = ty_right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)ty_right
{
    return CGRectGetMaxX(self.frame);
}

- (void)setTy_bottom:(CGFloat)ty_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = ty_bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)ty_bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)removeAllSubviews
{
    while (self.subviews.count)
    {
        UIView *child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (UIViewController*)viewController
{
    for (UIView *next = [self superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

+ (instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}
- (BOOL)intersectWithView:(UIView *)view
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    return CGRectIntersectsRect(selfRect, viewRect);
}
- (BOOL)isShowInKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect windowBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, windowBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

@end
