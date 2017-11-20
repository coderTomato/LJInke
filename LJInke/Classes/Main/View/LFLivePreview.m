//
//  LFLivePreview.m
//  LJInke
//
//  Created by Robin on 17/11/20.
//  Copyright © 2017年 Robin. All rights reserved.
//

#import "LFLivePreview.h"
#import <LFLiveKit/LFLiveKit.h>

static int padding = 30;

@interface LFLivePreview()<LFLiveSessionDelegate>

//美颜
@property (nonatomic, strong) UIButton *beautyButton;
//切换前后摄像头
@property (nonatomic, strong) UIButton *cameraButton;
//关闭
@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) LFLiveDebug *debugInfo;

@property (nonatomic, strong) LFLiveSession *session;

@end

@implementation LFLivePreview

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        //加载视频录制
        [self requestAccessForVideo];
        
        //加载音频录制
        [self requestAccessForAudio];
        
        //创建界面容器
        [self addSubview:self.containerView];
        
        // 添加按钮
        [self.containerView addSubview:self.closeButton];
        [self.containerView addSubview:self.cameraButton];
        [self.containerView addSubview:self.beautyButton];
    }
    return self;
}

#pragma mark --<加载视频录制>
- (void)requestAccessForVideo
{
    __weak typeof(self) _self = self;
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusNotDetermined: {
            // 许可对话没有出现，发起授权许可
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_self.session setRunning:YES];
                    });
                }
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized: {
            // 已经开启授权，可继续
            dispatch_async(dispatch_get_main_queue(), ^{
                [_self.session setRunning:YES];
            });
            break;
        }
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
            // 用户明确地拒绝授权，或者相机设备无法访问
            break;
        default:
            break;
    }
}

#pragma mark ---- <加载音频录制>
- (void)requestAccessForAudio
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    switch (status) {
        case AVAuthorizationStatusNotDetermined: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized: {
            break;
        }
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
            break;
        default:
            break;
    }
}

#pragma mark ---- <LFStreamingSessionDelegate>
/** live status changed will callback */
- (void)liveSession:(nullable LFLiveSession *)session liveStateDidChange:(LFLiveState)state{
    
}

/** live debug info callback */
- (void)liveSession:(nullable LFLiveSession *)session debugInfo:(nullable LFLiveDebug*)debugInfo{
    
}

/** callback socket errorcode */
- (void)liveSession:(nullable LFLiveSession*)session errorCode:(LFLiveSocketErrorCode)errorCode{
    
}


#pragma mark -- <创建会话>
//直播会话状态
- (LFLiveSession *)session
{
    if (!_session)
    {
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfiguration]];
        _session.running = YES;
        _session.preView = self;
    }
    return _session;
}

#pragma mark ---- <界面容器>
- (UIView *)containerView
{
    if(!_containerView)
    {
        _containerView = [UIView new];
        _containerView.frame = self.bounds;
        _containerView.backgroundColor = [UIColor clearColor];
        _containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _containerView;
}

#pragma mark ---- <关闭界面>
- (UIButton*)closeButton
{
    // 显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:false];
    
    if(!_closeButton)
    {
        _closeButton = [UIButton new];
        //位置
        _closeButton.frame = CGRectMake(ScreenW - padding * 2, padding, padding, padding);
        [_closeButton setImage:[UIImage imageNamed:@"close_preview"] forState:UIControlStateNormal];
        _closeButton.exclusiveTouch = YES;
        
        @weakify(self);
        [_closeButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
            @strongify(self);
            [self stopLive];
            [self.viewController dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    return _closeButton;
}

#pragma mark ---- <切换摄像头>
- (UIButton *)cameraButton
{
    if (!_cameraButton) {
        _cameraButton = [UIButton new];
        _cameraButton.size = CGSizeMake(44, 44);
        _cameraButton.origin = CGPointMake(_closeButton.left - 10 - _cameraButton.width, 20);
        [_cameraButton setImage:[UIImage imageNamed:@"camra_preview"] forState:UIControlStateNormal];
        _cameraButton.exclusiveTouch = YES;
        __weak typeof(self) _self = self;
        [_cameraButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
            //切换前后摄像头的方法
            AVCaptureDevicePosition devicePositon = _self.session.captureDevicePosition;
            _self.session.captureDevicePosition = (devicePositon == AVCaptureDevicePositionBack) ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
        }];
    }
    return _cameraButton;
}
#pragma mark ---- <美颜功能>
- (UIButton *)beautyButton
{
    if (!_beautyButton)
    {
        _beautyButton = [UIButton new];
        _beautyButton.size = CGSizeMake(44, 44);
        _beautyButton.origin = CGPointMake(_cameraButton.left - 10 - _beautyButton.width, 20);
        [_beautyButton setImage:[UIImage imageNamed:@"camra_beauty"] forState:UIControlStateNormal];
        [_beautyButton setImage:[UIImage imageNamed:@"camra_beauty_close"] forState:UIControlStateSelected];
        _beautyButton.exclusiveTouch = YES;
        __weak typeof(self) _self = self;
        [_beautyButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
            //切换美颜效果GPUImage
            _self.session.beautyFace = !_self.session.beautyFace;
            _self.beautyButton.selected = !_self.session.beautyFace;
        }];
    }
    return _beautyButton;
}

- (void)startLive
{
    //开启直播
    LFLiveStreamInfo *stream = [LFLiveStreamInfo new];
    stream.url = @"rtmp://live.hkstv.hk.lxdns.com:1935/live/lijun";
    [self.session startLive:stream];
}

- (void)stopLive
{
    //结束直播
    [self.session stopLive];
}

@end
