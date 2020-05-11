//
//  EVOLocation.h
//  EarthNews
//
//  Created by mr_huang on 2020/5/11.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EVOLocation : NSObject


@property (nonatomic, copy) NSString *country;


+ (instancetype)shareInstance;

- (void)registerLocationAMap;

- (void)getUserLocationAddress;

@end


