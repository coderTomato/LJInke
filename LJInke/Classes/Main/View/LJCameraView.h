//
//  LJCameraView.h
//  LJInke
//
//  Created by Robin on 17/11/20.
//  Copyright © 2017年 Robin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LJCameraViewType) {
    LJCameraViewTypeLive = 10,
    LJCameraViewTypeLittleVideo
};

@interface LJCameraView : UIView

//直播
@property (nonatomic,strong) UIButton *liveButton;
//短视频
@property (nonatomic,strong) UIButton *videoButton;
@property (nonatomic,strong) UIButton *closeButton;
@property (nonatomic,strong) UIView *backView;

@property (nonatomic, copy) void (^buttonClick)(LJCameraViewType type);


- (void)popShow;

@end
