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
@property (nonatomic, strong) EVOUserCommunityDataObj * userDataObj;
@property (nonatomic, copy) void(^clickDeleteMyCommunityBlock)(EVOUserCommunityDataObj * dataObj);
@end

NS_ASSUME_NONNULL_END
