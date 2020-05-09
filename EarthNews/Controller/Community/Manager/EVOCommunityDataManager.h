//
//  EVOCommunityDataManager.h
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EVOUserCommunityDataObj.h"
NS_ASSUME_NONNULL_BEGIN

@interface EVOCommunityDataManager : NSObject
kSPrStrong(NSMutableArray <EVOUserCommunityDataObj *>* homeSourceArray);  //首页动态列表
kSPrStrong(NSMutableArray <EVOUserCommunityDataObj *>* dataSourceArray);  //动态列表
kSPrStrong(NSMutableArray <EVOUserCommunityDataObj *>* mySelfSourceArray);//自己的动态
kSPrStrong(NSMutableArray <EVOUserCommunityDataObj *>* othreSourceArray); //他人的动态

+ (EVOCommunityDataManager *)shareCommunityDataManager;

//发布我自己的动态 需要存储下来 个人中心需要展示
- (void)submitMySelfCommunityData:(EVOUserCommunityDataObj *)dataObj;

//点赞他人的动态 需要存储下来 个人中心需要展示
- (void)addGoodsOtherCommunityData:(EVOUserCommunityDataObj *)dataObj;

//删除我自己的动态
- (void)removeMySelfCommunityData:(EVOUserCommunityDataObj *)dataObj;

//删除点赞他人的动态
- (void)removeAddGoodCommunityData:(EVOUserCommunityDataObj *)dataObj;

//屏蔽他人动态
- (void)shieldOtherCommunityData:(EVOUserCommunityDataObj *)dataObj;

//删除账号
- (void)removeLocalData;
@end

NS_ASSUME_NONNULL_END
