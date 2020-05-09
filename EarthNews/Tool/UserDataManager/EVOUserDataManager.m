//
//  EVOUserDataManager.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOUserDataManager.h"
#import "EVOCommunityDataManager.h"

#define EVOAccountPath [EVOAccountFilePath stringByAppendingPathComponent:@"EVOAccount.plist"]
#define EVOAccountFilePath [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"EVOUserAccount"]

@implementation EVOUserDataManager

+ (EVOUserDataManager *)shareUserDataManager {
    static EVOUserDataManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [EVOUserDataManager new];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self checkPath];
    }
    return self;
}

- (void)checkPath {
    if (!([self isFileExist])) {
        [self createDirectory];
    }
}

/**
 *  判断文件是否已经在沙盒中已经存在
 */
- (BOOL)isFileExist {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:EVOAccountPath];
    return result;
}

/**
 *  创建目录
 */
- (BOOL)createDirectory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL result = [fileManager createDirectoryAtPath:EVOAccountFilePath withIntermediateDirectories:YES attributes:nil error:&error];
    return result;
}

- (BOOL)isLogin {
    if (self.userDataObj) {
        return YES;
    }return NO;
}

- (void)logOut {
    if ([self isFileExist]) {
        NSError *err;
        [[NSFileManager defaultManager] removeItemAtPath:EVOAccountPath error:&err];
    }
    [self showToastText:@"删除成功!"];
    [[NSNotificationCenter defaultCenter] postNotificationName:EVOUserLogOutSuccessKey object:nil];
    //删除本地存储历史数据
    [[EVOCommunityDataManager shareCommunityDataManager] removeLocalData];
}

- (void)saveUserData:(EVOUserDataObj *)userDataObj {
    [NSKeyedArchiver archiveRootObject:userDataObj toFile:EVOAccountPath];
    self.userDataObj = userDataObj;
}

#pragma mark - lazy init
- (EVOUserDataObj *)userDataObj {
    if (_userDataObj == nil) {
        if ([self isFileExist]) {
            _userDataObj = [NSKeyedUnarchiver unarchiveObjectWithFile:EVOAccountPath];
        }
    }
    return _userDataObj;
}

@end
