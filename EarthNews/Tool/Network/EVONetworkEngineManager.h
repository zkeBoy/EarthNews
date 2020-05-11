//
//  EVONetworkEngineManager.h
//  EarthNews
//
//  Created by zkeBoy on 2020/5/7.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EVONetworkURLPathManager.h"

typedef NS_ENUM(NSUInteger, HTTPMethod) {
    HTTPMethodGet    = 1,
    HTTPMethodPost   = 2
};

NS_ASSUME_NONNULL_BEGIN

@interface EVONetworkEngineManager : NSObject

+ (EVONetworkEngineManager *)shareNetworkEngineManager;

- (void)requestWithHTTPMethod:(HTTPMethod)method
                    URLString:(NSString *_Nullable)URLString
                   parameters:(id _Nullable)parameters
                     response:(void (^_Nullable)(id _Nullable result))responseBlock;

@end

NS_ASSUME_NONNULL_END
