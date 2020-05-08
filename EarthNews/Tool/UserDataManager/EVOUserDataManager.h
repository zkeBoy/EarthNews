//
//  EVOUserDataManager.h
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EVOUserDataObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface EVOUserDataManager : NSObject
@property (nonatomic, strong) EVOUserDataObj * userDataObj;

+ (EVOUserDataManager *)shareUserDataManager ;
- (BOOL)isLogin; //是否登录
- (void)logOut; //退出登录
- (void)saveUserData:(EVOUserDataObj *)userDataObj;

@end

NS_ASSUME_NONNULL_END
