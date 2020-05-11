//
//  EVOLocation.m
//  EarthNews
//
//  Created by mr_huang on 2020/5/11.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOLocation.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface EVOLocation ()<AMapLocationManagerDelegate>
@property (nonatomic, strong) AMapLocationManager *locationManager;
@end

@implementation EVOLocation

+ (instancetype)shareInstance
{
    static EVOLocation * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[EVOLocation alloc]init];
    });
    return instance;
}


- (void)registerLocationAMap {
    [AMapServices sharedServices].apiKey = EVOAMapKey;
}

- (void)getUserLocationAddress
{
    self.locationManager = [[AMapLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [self loactionAction];
}

-(void)loactionAction {
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error) {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            if (error.code == AMapLocationErrorLocateFailed) {
                return;
            }
        }
        
        NSLog(@"location:%@", location);
        if (regeocode) {
            NSLog(@"reGeocode:%@", regeocode);
            NSLog(@"纬度:%f,经度:%f",location.coordinate.latitude,
                 location.coordinate.longitude);
            self.latitude = location.coordinate.latitude;
            self.longitude = location.coordinate.longitude;
            self.country = regeocode.country;
            self.city = regeocode.city;
            
            //返回是否在大陆或以外地区，返回YES为大陆地区，NO为非大陆。
            BOOL flag = AMapLocationDataAvailableForCoordinate(location.coordinate);
            if (flag) {//大陆
                
            } else {//海外
                
            }
        }
    }];
}

- (NSString *)country {
    if (_country) {
        return _country;
    } else {
        return @"";
    }
}

@end
