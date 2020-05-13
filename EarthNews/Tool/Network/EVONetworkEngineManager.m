//
//  EVONetworkEngineManager.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/7.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <AFNetworking/AFNetworking-umbrella.h>
#import "EVONetworkEngineManager.h"

#define requestTimeOut 10.f

@implementation EVONetworkEngineManager

+ (EVONetworkEngineManager *)shareNetworkEngineManager {
    static EVONetworkEngineManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [EVONetworkEngineManager new];
    });
    return manager;
}

- (void)requestWithHTTPMethod:(HTTPMethod)method URLString:(NSString *_Nullable)URLString parameters:(id _Nullable)parameters response:(void (^_Nullable)(id _Nullable result))responseBlock {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = requestTimeOut;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    switch (method) {
        case HTTPMethodGet:{
            [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (responseBlock) {
                    responseBlock(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }
            break;
        case HTTPMethodPost:{
            [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (responseBlock) {
                    responseBlock(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }
            break;
        default:
            break;
    }
}

@end
