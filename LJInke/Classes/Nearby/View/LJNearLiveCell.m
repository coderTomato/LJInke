//
//  LJNearLiveCell.m
//  LJInke
//
//  Created by Robin on 17/11/20.
//  Copyright © 2017年 Robin. All rights reserved.
//

#import "LJNearLiveCell.h"

@interface LJNearLiveCell()

@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation LJNearLiveCell

- (void)showAnimation {
    
    if (self.live.isShow)return;
    
    self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    [UIView animateWithDuration:0.5 animations:^{
        
        self.layer.transform = CATransform3DMakeScale(1, 1, 1);
        self.live.show = YES;
    }];
}

- (void)setLive:(LJLive *)live {
    
    _live = live;
    
    [self.headView sd_setImageWithURL:[NSURL URLWithString:live.creator.portrait] placeholderImage:[UIImage imageNamed:@"rectangleDefaultAvatar"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
    self.distanceLabel.text = live.distance;
}

@end
