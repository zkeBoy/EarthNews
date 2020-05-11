//
//  EVODynamicInfoView.h
//  EarthNews
//
//  Created by mr_huang on 2020/5/9.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "EVOUserCommunityDataObj.h"

typedef void(^btnsOnClickBlock)(NSInteger btnTag);
@interface EVODynamicInfoView : MAAnnotationView
@property (nonatomic, copy) btnsOnClickBlock btnsOnClickBlock;
@property (nonatomic, strong) EVOUserCommunityDataObj * dataObj;
- (void)setInfoWithObj:(EVOUserCommunityDataObj *)obj;
@end


