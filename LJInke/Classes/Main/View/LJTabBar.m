//
//  LJTabBar.m
//  LJInke
//
//  Created by Robin on 17/11/20.
//  Copyright © 2017年 Robin. All rights reserved.
//

#import "LJTabBar.h"

@interface LJTabBar()

/** 发直播按钮*/
@property (weak, nonatomic) UIButton *publishBtn;

@end

@implementation LJTabBar

- (UIButton *)publishBtn
{
    if (_publishBtn == nil)
    {
        UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        [publishBtn addTarget:self action:@selector(publishBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishBtn];
        _publishBtn = publishBtn;
    }
    return _publishBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_bg"]];
        [self setShadowImage:[[UIImage alloc] init]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
   
    /**** 按钮的尺寸 ****/
    CGFloat btnW = self.ty_width / 5;
    CGFloat btnH = self.ty_height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        if(![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        CGFloat buttonX = (index > 1 ? (index + 1) : index) * btnW;
        button.frame = CGRectMake(buttonX, 0, btnW, btnH);
        index++;
    }
    /**** 设置中间的按钮的frame ****/
    self.publishBtn.ty_size = self.publishBtn.currentBackgroundImage.size;
    self.publishBtn.ty_centerX = self.ty_width * 0.5;
    self.publishBtn.ty_centerY = self.ty_height * 0.2;
}

- (void)publishBtnClicked:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cameraButtonClick:)]) {
        [self.delegate cameraButtonClick:self];
    }
}

@end
