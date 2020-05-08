//
//  EVOUserDataManager.h
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EVOUserCommunityDataObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface EVOUserDataManager : NSObject

//存储点赞的数据
- (void)saveThumbs_UpToLocal:(EVOUserCommunityDataObj *)dataObj;

//读取本地点赞的数据
- (NSArray <EVOUserCommunityDataObj *>*)getThumbs_UpFromLocal;

@end

NS_ASSUME_NONNULL_END
