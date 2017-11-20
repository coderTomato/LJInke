//
//  NSCalendar+Extension.m
//  Basi
//
//  Created by lijun on 2016/12/18.
//  Copyright © 2016年 lijun. All rights reserved.
//

#import "NSCalendar+Extension.h"

@implementation NSCalendar (Extension)

+ (instancetype)calendar
{
    NSCalendar *calendar = nil;
    if ([calendar respondsToSelector:@selector(calendarWithIdentifier:)])
    {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    else
    {
        return [NSCalendar currentCalendar];
    }
}

@end
