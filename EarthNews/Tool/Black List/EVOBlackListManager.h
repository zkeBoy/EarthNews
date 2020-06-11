//
//  EVOBlackListManager.h
//  EarthNews
//
//  Created by zkeBoy on 2020/6/11.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EVOUserCommunityDataObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface EVOBlackListManager : NSObject

//加入黑名单
+ (void)addBlackList:(EVOUserCommunityDataObj *)dataObj;
//删除黑名单
+ (void)deleteBlackItem:(EVOUserCommunityDataObj *)dataObj;
//获取黑名单
+ (NSArray <EVOUserCommunityDataObj*>*)getAllBlackList;

@end

NS_ASSUME_NONNULL_END
