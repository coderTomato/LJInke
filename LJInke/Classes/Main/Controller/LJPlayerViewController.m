//
//  LJPlayerViewController.m
//  LJInke
//
//  Created by Robin on 17/11/20.
//  Copyright © 2017年 Robin. All rights reserved.
//

#import "LJPlayerViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface LJPlayerViewController ()

/** 直播播放器*/
@property (nonatomic, strong) IJKFFMoviePlayerController *player;
/** 毛玻璃视图*/
@property (strong, nonatomic) UIImageView *blurImageView;
/** 关闭*/
@property (strong, nonatomic) UIButton *closeBtn;

@end

@implementation LJPlayerViewController

- (UIButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"mg_room_btn_guan_h"] forState:UIControlStateNormal];
        [_closeBtn sizeToFit];
        _closeBtn.frame = CGRectMake(ScreenW - _closeBtn.ty_width - 10, ScreenH - _closeBtn.ty_height - 10, _closeBtn.ty_width, _closeBtn.ty_height);
        [_closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initPlayer];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    //注册直播需要用的通知
    [self regisNotificationObserver];
    //准备播放
    [self.player prepareToPlay];
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:self.closeBtn];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    //关闭直播
    [self.player shutdown];
    [self removeMovieNotificationObservers];
    [self.closeBtn removeFromSuperview];
}

- (void)closeAction:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupUI
{
    self.blurImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.blurImageView.userInteractionEnabled = YES;
    [self.blurImageView sd_setImageWithURL:[NSURL URLWithString:self.live.creator.portrait] placeholderImage:[UIImage imageNamed:@"rectangleDefaultAvatar"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
    [self.view addSubview:self.blurImageView];
    
    //创建毛玻璃效果
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //创建毛玻璃视图
    UIVisualEffectView * ve = [[UIVisualEffectView alloc] initWithEffect:blur];
    ve.frame = self.blurImageView.bounds;
    //毛玻璃视图加入图片view上
    [self.blurImageView addSubview:ve];
}

- (void)initPlayer {
    
    IJKFFOptions * options = [IJKFFOptions optionsByDefault];
    IJKFFMoviePlayerController * player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:self.live.streamAddr withOptions:options];
    self.player = player;
    self.player.view.frame = self.view.bounds;
    self.player.shouldAutoplay = YES;
    [self.view addSubview:self.player.view];
}

- (void)regisNotificationObserver
{
    //监听网络环境，监听缓冲方法
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    //监听直播完成回调
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    //监听用户主动操作
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
}

-(void)removeMovieNotificationObservers
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:_player];
}

- (void)loadStateDidChange:(NSNotification*)notification
{
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        DLog(@"loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: %d\n", (int)loadState);
    } else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        DLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        DLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
    
    self.blurImageView.hidden = YES;
    [self.blurImageView removeFromSuperview];
}

- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    
    switch (reason)
    {
        case IJKMPMovieFinishReasonPlaybackEnded:
            DLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            DLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            DLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            DLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification
{
    DLog(@"mediaIsPreparedToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification
{
    switch (_player.playbackState)
    {
        case IJKMPMoviePlaybackStateStopped: {
            DLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePlaying: {
            DLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            
            break;
        }
        case IJKMPMoviePlaybackStatePaused: {
            DLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateInterrupted: {
            DLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            DLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
        default: {
            DLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
}


@end
