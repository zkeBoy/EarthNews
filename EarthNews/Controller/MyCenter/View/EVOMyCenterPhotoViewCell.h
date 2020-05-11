//
//  EVOMyCenterPhotoViewCell.h
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EVOUserCommunityDataObj.h"
NS_ASSUME_NONNULL_BEGIN

@interface EVOMyCenterPhotoViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *localAddressTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImgView;
@property (weak, nonatomic) IBOutlet UIButton *rubbishBtn;
@property (nonatomic, strong) EVOUserCommunityDataObj * userDataObj;
@property (nonatomic, copy) void(^clickDeleteMyCommunityBlock)(EVOUserCommunityDataObj * dataObj);
@property (nonatomic, assign) NSInteger collectionType;  //0我的轨迹 1我的点赞
@end

NS_ASSUME_NONNULL_END
