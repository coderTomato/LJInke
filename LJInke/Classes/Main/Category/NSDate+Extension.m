//
//  NSDate+Extension.m
//  Basi
//
//  Created by lijun on 2016/12/18.
//  Copyright © 2016年 lijun. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar calendar];
    NSInteger unit = NSCalendarUnitYear;
    //获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    //获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return nowCmps == selfCmps;
    
}

- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar calendar];
    NSInteger unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return nowCmps.year == selfCmps.year && nowCmps.month == selfCmps.month && nowCmps.day == selfCmps.day;
}

- (BOOL)isYesterday
{
    NSCalendar *calendar = [NSCalendar calendar];
    NSInteger unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return selfCmps.year == nowCmps.year && selfCmps.month == nowCmps.month && selfCmps.day == nowCmps.day - 1;
}

@end
