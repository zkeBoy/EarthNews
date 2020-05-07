//
//  EVOMyCenterTopView.h
//  EarthNews
//
//  Created by zkeBoy on 2020/5/7.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EVOMyCenterCustomView.h"

NS_ASSUME_NONNULL_BEGIN

@interface EVOMyCenterTopView : UIView
@property (nonatomic, strong) UILabel  * textTitleLabel;
@property (nonatomic, strong) UIButton * settingBtn;
@property (nonatomic, strong) UIImageView * userHeadImgView;
@property (nonatomic, strong) UIButton * editeUserBtn;
@property (nonatomic, strong) EVOMyCenterCustomView * getGoodsView; //获赞
@property (nonatomic, strong) EVOMyCenterCustomView * followView; //关注
@property (nonatomic, strong) EVOMyCenterCustomView * myFansView; //粉丝
@property (nonatomic, strong) UIImageView * localAdderssImgView;
@property (nonatomic, strong) UILabel * localAddressLabel;
@end

NS_ASSUME_NONNULL_END
