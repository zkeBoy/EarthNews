//
//  EVOCommunityDataManager.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

//我的轨迹
#define EVOMyCenterCommunityFilePath [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"EVOMyCenterCommunityAccount"]
#define EVOMyCenterCommunityPath [EVOMyCenterCommunityFilePath stringByAppendingPathComponent:@"EVOMyCenterCommunityAccount.plist"]

//我的点赞
#define EVOAddGoodsFilePath [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"EVOAddGoodsAccount"]
#define EVOAddGoodsPath [EVOAddGoodsFilePath stringByAppendingPathComponent:@"EVOAddGoodsAccount.plist"]

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
        
        //我的轨迹文件路径创建
        [self checkMyCommunityPath];
        
        //我的点赞文件路径
        [self checkAddGoodsPath];
        
        //从本地读取我的轨迹
        NSArray * myCommunityArray = [NSKeyedUnarchiver unarchiveObjectWithFile:EVOMyCenterCommunityPath];
        if (myCommunityArray) {
            [self.mySelfSourceArray addObjectsFromArray:myCommunityArray];
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, myCommunityArray.count)];
            //将本地数据添加到动态列表中
            [self.dataSourceArray insertObjects:myCommunityArray atIndexes:indexSet];
        }
        
        NSArray * addGoodsArray = [NSKeyedUnarchiver unarchiveObjectWithFile:EVOAddGoodsPath];
        if (addGoodsArray) {
            [self.othreSourceArray addObjectsFromArray:addGoodsArray];
        }
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
    
    NSArray * arr = [self.mySelfSourceArray mutableCopy];
    
    //重新归档
    [self archiveDataToLocal:arr path:EVOMyCenterCommunityPath];
    
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
        
        NSArray * arr = [self.othreSourceArray mutableCopy];
        
        //重新归档
        [self archiveDataToLocal:arr path:EVOAddGoodsPath];
        
        //保存到本地
        
        [[NSNotificationCenter defaultCenter] postNotificationName:EVOUserAddGoodCommunitySuccessKey object:nil];
    }
}

//删除自己的动态
- (void)removeMySelfCommunityData:(EVOUserCommunityDataObj *)dataObj {
    if ([self.mySelfSourceArray containsObject:dataObj]) {
        [self.mySelfSourceArray removeObject:dataObj];
        
        NSArray * arr = [self.mySelfSourceArray mutableCopy];
        
        //重新归档
        [self archiveDataToLocal:arr path:EVOMyCenterCommunityPath];
        
        //从动态列表中删除
        if ([self.dataSourceArray containsObject:dataObj]) {
            [self.dataSourceArray removeObject:dataObj];
        }
        
        //刷新个人中心列表
        [[NSNotificationCenter defaultCenter] postNotificationName:EVOUserSubmitCommunitySuccessKey object:nil];
    }
}

//删除点赞的动态
- (void)removeAddGoodCommunityData:(EVOUserCommunityDataObj *)dataObj {
    if ([self.othreSourceArray containsObject:dataObj]) {
        [self.othreSourceArray removeObject:dataObj];
        
        //从本地删除数据
        NSArray * arr = [self.othreSourceArray mutableCopy];
        
        //重新归档
        [self archiveDataToLocal:arr path:EVOAddGoodsPath];
        
        //刷新点赞数据列表
        [[NSNotificationCenter defaultCenter] postNotificationName:EVOUserAddGoodCommunitySuccessKey object:nil];
    }
}

//屏蔽
- (void)shieldOtherCommunityData:(EVOUserCommunityDataObj *)dataObj {
    if ([self.dataSourceArray containsObject:dataObj]) {
        [self.dataSourceArray removeObject:dataObj];
    }
    
    //发送通知刷新列表
    [[NSNotificationCenter defaultCenter] postNotificationName:EVOShildeOtherCommunitySuccessKey object:nil];
}

#pragma mark - Archive Path
- (void)checkMyCommunityPath {
    if (!([self isFileExist:EVOMyCenterCommunityPath])) {
        [self createDirectory:EVOMyCenterCommunityFilePath];
    }
}

- (void)checkAddGoodsPath {
    if (!([self isFileExist:EVOAddGoodsPath])) {
        [self createDirectory:EVOAddGoodsFilePath];
    }
}

/**
 *  判断文件是否已经在沙盒中已经存在
 */
- (BOOL)isFileExist:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:path];
    return result;
}

/**
 *  创建目录
 */
- (BOOL)createDirectory:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL result = [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
    return result;
}

- (void)archiveDataToLocal:(NSArray *)arr path:(NSString *)path {
    //保存到本地
    [NSKeyedArchiver archiveRootObject:arr toFile:path];
}

- (void)removeLocalData {
    if (self.mySelfSourceArray.count) {
        [self.dataSourceArray removeObjectsInArray:self.mySelfSourceArray];
    }
    
    [self.mySelfSourceArray removeAllObjects];
    [self.othreSourceArray removeAllObjects];
    
    if ([self isFileExist:EVOMyCenterCommunityPath]) {
        NSError *err;
        [[NSFileManager defaultManager] removeItemAtPath:EVOMyCenterCommunityPath error:&err];
        //刷新个人中心列表
        [[NSNotificationCenter defaultCenter] postNotificationName:EVOUserSubmitCommunitySuccessKey object:nil];
    }

    if ([self isFileExist:EVOAddGoodsPath]) {
        NSError *err;
        [[NSFileManager defaultManager] removeItemAtPath:EVOAddGoodsPath error:&err];
        //刷新点赞数据列表
        [[NSNotificationCenter defaultCenter] postNotificationName:EVOUserAddGoodCommunitySuccessKey object:nil];
    }
    
    
}

@end
