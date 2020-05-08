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
kSPrStrong(NSMutableArray <EVOUserCommunityDataObj *>* dataSourceArray);
@end

NS_ASSUME_NONNULL_END
