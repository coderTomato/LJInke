//
//  UIView+UIView_MBProgressHUD.m
//  BaiFuBeauty
//
//  Created by 李军 on 13-5-26.
//  Copyright (c) 2013年 李军. All rights reserved.
//

#import "UIView_MBProgressHUD.h"

@implementation UIView (UIView_MBProgressHUD)

- (MBProgressHUD *)showLoadingMeg:(NSString *)meg
{
    MBProgressHUD *hudView = [MBProgressHUD HUDForView:self];
    if (!hudView) {
        hudView = [MBProgressHUD showHUDAddedTo:self animated:YES];
    }
    else
    {
        [hudView show:YES];
    }
    hudView.detailsLabelText = meg;
    return hudView;
}
- (void)hideLoading
{
    [MBProgressHUD hideHUDForView:self animated:YES];
}
- (void)showLoadingMeg:(NSString *)meg time:(NSUInteger)time
{
    MBProgressHUD *hud = [self showLoadingMeg:meg];
    hud.mode = MBProgressHUDModeCustomView;
    if (time > 0) {
        [self performSelector:@selector(hideLoading) withObject:nil afterDelay:time];
    }
}
- (void)delayHideLoading
{
    [self performSelector:@selector(hideLoading) withObject:nil afterDelay:kDefaultShowTime];
}

- (void)showSuccess:(NSString *)success
{
    [self show:success icon:@"success.png"];
}

- (void)showError:(NSString *)error
{
    [self show:error icon:@"error.png"];
}

- (void)show:(NSString *)text icon:(NSString *)icon
{
    MBProgressHUD *hudView = [self showLoadingMeg:text];
    hudView.color = [UIColor redColor];
    // 设置图片
    hudView.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hudView.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hudView.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hudView hide:YES afterDelay:1.0];
    
}

@end
