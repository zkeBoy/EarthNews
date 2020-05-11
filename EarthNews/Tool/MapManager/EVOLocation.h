//
//  EVOLocation.h
//  EarthNews
//
//  Created by mr_huang on 2020/5/11.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EVOLocation : NSObject
@property (nonatomic, assign) CLLocationDegrees latitude;  //精度
@property (nonatomic, assign) CLLocationDegrees longitude; //维度
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *city;

+ (instancetype)shareInstance;
- (void)registerLocationAMap;
- (void)getUserLocationAddress;

@end


