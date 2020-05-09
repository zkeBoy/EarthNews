//
//  EVOCommunityDataManager.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOCommunityDataManager.h"

@implementation EVOCommunityDataManager

+ (EVOCommunityDataManager *)shareCommunityDataManager {
    static EVOCommunityDataManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [EVOCommunityDataManager new];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dataSourceArray = [NSMutableArray array];
        [self readLocalJsonData];
    }
    return self;
}

- (void)readLocalJsonData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!jsonData || error) {
        NSLog(@"JSON解码失败");
    }else {
        self.dataSourceArray = [EVOUserCommunityDataObj mj_objectArrayWithKeyValuesArray:jsonObj];
    }
}

#pragma mark - Private Method
//发布动态
- (void)submitMySelfCommunityData:(EVOUserCommunityDataObj *)dataObj {
    [self.dataSourceArray insertObject:dataObj atIndex:0];
    
    [self.mySelfSourceArray addObject:dataObj];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EVOUserSubmitCommunitySuccessKey object:nil];
}

//添加点赞动态
- (void)addGoodsOtherCommunityData:(EVOUserCommunityDataObj *)dataObj {
    [self.othreSourceArray addObject:dataObj];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EVOUserAddGoodCommunitySuccessKey object:nil];
}

//删除自己的动态
- (void)removeMySelfCommunityData:(EVOUserCommunityDataObj *)dataObj {
    
}

//删除点赞的动态
- (void)removeAddGoodCommunityData:(EVOUserCommunityDataObj *)dataObj {
    
}

@end
