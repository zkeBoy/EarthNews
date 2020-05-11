//
//  EVOUserDataObj.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOUserDataObj.h"
#import "EVOLocation.h"

@implementation EVOUserDataObj
MJCodingImplementation

- (void)setBirthDay:(NSString *)birthDay {
    _birthDay = birthDay;
    NSString * yearString = [birthDay substringToIndex:4];
    // 2.获取当前时间
    NSCalendar *calendar0 = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    comps = [calendar0 components:unitFlags fromDate:[NSDate date]];
    NSInteger year = [comps year];
    NSInteger age = year - yearString.integerValue;
    self.userAge = NSFormatInt(age);
}

- (NSString *)location {
    if (!_location.length) {
        if (![EVOLocation shareInstance].city) {
            return @"未知";
        }
        return [EVOLocation shareInstance].city;
    }
    return _location;
}

@end
