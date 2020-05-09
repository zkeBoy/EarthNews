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
        self.mySelfSourceArray = [NSMutableArray array];
        self.othreSourceArray = [NSMutableArray array];
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
    BOOL isExist = NO;
    //判断本地是否已经添加过这个数据
    for (EVOUserCommunityDataObj * obj in self.othreSourceArray) {
        if ([obj.ID isEqualToString:dataObj.ID]) {
            isExist = YES;
            break;
        }
    }
    
    if (!isExist) {
        [self.othreSourceArray addObject:dataObj];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:EVOUserAddGoodCommunitySuccessKey object:nil];
    }
}

//删除自己的动态
- (void)removeMySelfCommunityData:(EVOUserCommunityDataObj *)dataObj {
    if ([self.mySelfSourceArray containsObject:dataObj]) {
        [self.mySelfSourceArray removeObject:dataObj];
     
        //刷新个人中心列表
        //[[NSNotificationCenter defaultCenter] postNotificationName:EVOUserSubmitCommunitySuccessKey object:nil];
    }
}

//删除点赞的动态
- (void)removeAddGoodCommunityData:(EVOUserCommunityDataObj *)dataObj {
    if ([self.othreSourceArray containsObject:dataObj]) {
        [self.othreSourceArray removeObject:dataObj];
        
        //刷新点赞数据列表
        //[[NSNotificationCenter defaultCenter] postNotificationName:EVOUserAddGoodCommunitySuccessKey object:nil];
    }
}

@end
