//
//  LJHotCell.h
//  LJInke
//
//  Created by Robin on 17/11/20.
//  Copyright © 2017年 Robin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJLive.h"

@interface LJHotCell : UITableViewCell

//头像
@property (nonatomic,strong) UIImageView *iconImageView;

//名字
@property (nonatomic,strong) UILabel *nameLabel;

//所在城市
@property (nonatomic,strong) UILabel *cityLabel;

//在线人数
@property (nonatomic,strong) UILabel *onLineLabel;

//封面
@property (nonatomic,strong) UIImageView *coverImageView;

//心情？？
@property (nonatomic,strong) UILabel *moodLabel;

//直播logo
@property (nonatomic,strong) UIImageView *logoImageView;

/** <#注释#>*/
@property (strong, nonatomic) LJLive *live;

@end
