//
//  LJNearLiveCell.h
//  LJInke
//
//  Created by Robin on 17/11/20.
//  Copyright © 2017年 Robin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJLive.h"


@interface LJNearLiveCell : UICollectionViewCell


@property (strong, nonatomic) LJLive *live;

- (void)showAnimation;

@end
