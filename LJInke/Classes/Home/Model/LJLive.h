//
//  LJLive.h
//  LJInke
//
//  Created by Robin on 17/11/20.
//  Copyright © 2017年 Robin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJCreator.h"

@interface LJLive : NSObject

/***  地区*/
@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) LJCreator * creator;
@property (nonatomic, assign) NSInteger group;
@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) NSString * image;
@property (nonatomic, assign) NSInteger link;
@property (nonatomic, assign) NSInteger multi;
/***  在线*/
@property (nonatomic, assign) NSInteger onlineUsers;
@property (nonatomic, assign) NSInteger optimal;
@property (nonatomic, assign) NSInteger pubStat;
@property (nonatomic, assign) NSInteger roomId;
@property (nonatomic, assign) NSInteger rotate;
@property (nonatomic, strong) NSString * shareAddr;
@property (nonatomic, assign) NSInteger slot;
@property (nonatomic, assign) NSInteger status;
/***  播放流*/
@property (nonatomic, strong) NSString * streamAddr;
@property (nonatomic, assign) NSInteger version;

@property (nonatomic, copy) NSString * distance;
@property (nonatomic, getter=isShow) BOOL show;


@end
