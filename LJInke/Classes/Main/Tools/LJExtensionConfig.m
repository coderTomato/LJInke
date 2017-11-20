//
//  LJExtensionConfig.m
//  LJInke
//
//  Created by Robin on 17/11/20.
//  Copyright © 2017年 Robin. All rights reserved.
//

#import "LJExtensionConfig.h"
#import "LJCreator.h"
#import "LJLive.h"

@implementation LJExtensionConfig

+ (void)load
{
    [LJLive mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"onlineUsers" : @"online_users",
                 @"pubStat" : @"pub_stat",
                 @"roomId" : @"room_id",
                 @"thirdPlatform" : @"third_platform",
                 @"shareAddr" : @"share_addr",
                 @"streamAddr" : @"stream_addr"
                 };
    }];
    
    [LJCreator mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"desc" : @"description",
                 @"inkeVerify" : @"inke_verify",
                 @"rankVeri" : @"rank_veri",
                 @"thirdPlatform" : @"third_platform",
                 @"veriInfo" : @"veri_info",
                 @"verifiedReason" : @"verified_reason"
                 };
    }];
    
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID" : @"id"};
    }];
}

@end
