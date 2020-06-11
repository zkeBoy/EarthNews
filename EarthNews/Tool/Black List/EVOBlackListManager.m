//
//  EVOBlackListManager.m
//  EarthNews
//
//  Created by zkeBoy on 2020/6/11.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#define BlackListUserPath [BlackListUserFilePath stringByAppendingPathComponent:@"blackList.plist"]
#define BlackListUserFilePath [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"EarthNews"]

#import "EVOBlackListManager.h"

@implementation EVOBlackListManager

+ (void)addBlackList:(EVOUserCommunityDataObj *)dataObj {
    [self checkPath];
    
    NSArray * arr = [NSKeyedUnarchiver unarchiveObjectWithFile:BlackListUserPath];
    NSMutableArray * list = [NSMutableArray array];
    if (arr.count) {
        [list addObjectsFromArray:arr];
        BOOL exist = NO;
        for (EVOUserCommunityDataObj * model in arr) {
            if ([model.ID isEqualToString:dataObj.ID]) {
                exist = YES;
                break;
            }
        }
        if (exist) {//已经存在了不需要再次存储
            return;
        }
    }
    [list addObject:dataObj];
    [NSKeyedArchiver archiveRootObject:[list mutableCopy] toFile:BlackListUserPath];
}

+ (void)deleteBlackItem:(EVOUserCommunityDataObj *)dataObj {
    NSArray * arr = [NSKeyedUnarchiver unarchiveObjectWithFile:BlackListUserPath];
    NSMutableArray * list = [NSMutableArray array];
    if (!arr.count) {
        return;
    }else {
        for (EVOUserCommunityDataObj * model in arr) {
            if (![model.ID isEqualToString:dataObj.ID]) {
                [list addObject:model];
            }
        }
        [NSKeyedArchiver archiveRootObject:[list mutableCopy] toFile:BlackListUserPath];
    }
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:EVORemoveBlackListSuccessKey object:nil];
}

+ (NSArray<EVOUserCommunityDataObj *> *)getAllBlackList {
    [self checkPath];
    NSArray * arr = [NSKeyedUnarchiver unarchiveObjectWithFile:BlackListUserPath];
    return arr;
}

#pragma mark - File Path
+ (void)checkPath {
    if (!([self isFileExist])) {
        [self createDirectory];
    }
}

//判断文件是否已经在沙盒中已经存在
+ (BOOL)isFileExist {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:BlackListUserPath];
    return result;
}

//创建目录
+ (BOOL)createDirectory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL result = [fileManager createDirectoryAtPath:BlackListUserFilePath withIntermediateDirectories:YES attributes:nil error:&error];
    return result;
}

@end
