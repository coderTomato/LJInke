//
//  LJCreator.h
//  LJInke
//
//  Created by Robin on 17/11/20.
//  Copyright © 2017年 Robin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJCreator : NSObject

@property (nonatomic, strong) NSString * birth;
@property (nonatomic, strong) NSString * desc;
@property (nonatomic, strong) NSString * emotion;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) NSInteger gmutex;
@property (nonatomic, strong) NSString * hometown;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger inkeVerify;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) NSString * location;
/***  名字*/
@property (nonatomic, strong) NSString * nick;
/***  头像*/
@property (nonatomic, strong) NSString * portrait;
@property (nonatomic, strong) NSString * profession;
@property (nonatomic, assign) NSInteger rankVeri;
@property (nonatomic, strong) NSString * thirdPlatform;
@property (nonatomic, strong) NSString * veriInfo;
@property (nonatomic, assign) NSInteger verified;
@property (nonatomic, strong) NSString * verifiedReason;

@end
