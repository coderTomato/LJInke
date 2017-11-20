//
//  LJCameraView.m
//  LJInke
//
//  Created by Robin on 17/11/20.
//  Copyright © 2017年 Robin. All rights reserved.
//

#import "LJCameraView.h"

#define LiveWidth ScreenW/2 //button的宽高
#define LiveGetY ScreenH - 50 - ScreenW/2 //灰色区域高度

@implementation LJCameraView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = LJColorA(0, 0, 0, 0.3);
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self addSubview:self.backView];
    [self addSubview:self.liveButton];
    [self addSubview:self.videoButton];
    [self addSubview:self.closeButton];
}

- (void)popShow
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}

- (void)closeClick
{
    [self removeFromSuperview];
}

- (UIButton *)liveButton
{
    if (_liveButton == nil)
    {
        _liveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _liveButton.backgroundColor = [UIColor clearColor];
        [_liveButton setImage:[UIImage imageNamed:@"shortvideo_main_live"] forState:UIControlStateNormal];
        [_liveButton setTitle:@"直播" forState:UIControlStateNormal];
        [_liveButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _liveButton.frame = CGRectMake(0, ScreenH, LiveWidth, LiveWidth);
        [_liveButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
        _liveButton.tag = LJCameraViewTypeLive;
        [_liveButton addTarget:self action:@selector(liveClick:) forControlEvents:UIControlEventTouchUpInside];
        //关键帧  damp阻尼
        [UIView animateWithDuration:0.8 delay:0.1 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _liveButton.frame = CGRectMake(0, LiveGetY, LiveWidth, LiveWidth);
        } completion:^(BOOL finished) {
            
        }];
    }
    return _liveButton;
}

- (UIButton *)videoButton
{
    if (_videoButton == nil) {
        _videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _videoButton.backgroundColor = [UIColor clearColor];
        [_videoButton setImage:[UIImage imageNamed:@"shortvideo_main_video"] forState:UIControlStateNormal];
        [_videoButton setTitle:@"短视频" forState:UIControlStateNormal];
        [_videoButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _videoButton.frame = CGRectMake(LiveWidth, ScreenH, LiveWidth, LiveWidth);
        _videoButton.tag = LJCameraViewTypeLittleVideo;
        [_videoButton addTarget:self action:@selector(liveClick:) forControlEvents:UIControlEventTouchUpInside];
        [_videoButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
        //关键帧  damp阻尼
        [UIView animateWithDuration:0.8 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _videoButton.frame = CGRectMake(LiveWidth, LiveGetY, LiveWidth, LiveWidth);
        } completion:^(BOOL finished) {
            
        }];
    }
    return _videoButton;
}

- (void)liveClick:(UIButton *)sender{
    if (self.buttonClick)
    {
        self.buttonClick(sender.tag);
    }
    [self closeClick];
}

//点击上方灰色区域移除视图
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [allTouches anyObject];
    CGPoint point = [touch locationInView:self];
    if ( point.y < LiveGetY) {
        [self removeFromSuperview];
    }
}

- (UIButton *)closeButton
{
    if (_closeButton == nil)
    {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.backgroundColor = [UIColor whiteColor];
        [_closeButton setImage:[UIImage imageNamed:@"shortvideo_launch_close"] forState:UIControlStateNormal];
        _closeButton.frame = CGRectMake(0, ScreenH - 50, ScreenW, 50);
        [_closeButton addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UIView *)backView{
    if (_backView == nil)
    {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenH - 50 - LiveWidth, ScreenW, LiveWidth)];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}


@end
