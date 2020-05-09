//
//  EVOCommunityViewCell.h
//  EarthNews
//
//  Created by zkeBoy on 2020/5/7.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EVOUserCommunityDataObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface EVOCommunityViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImgView;
@property (weak, nonatomic) IBOutlet UILabel *userNameTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureOneImgView;
@property (weak, nonatomic) IBOutlet UIImageView *pictureTwoImgView;
@property (weak, nonatomic) IBOutlet UIImageView *pictureThreeImgView;
@property (weak, nonatomic) IBOutlet UILabel *localAddressLabel;
@property (weak, nonatomic) IBOutlet UIView *privateMessageBtn;
@property (weak, nonatomic) IBOutlet UIView *commentBtn;
@property (weak, nonatomic) IBOutlet UILabel *commentTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *commentImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spaceOne;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spaceThree;
@property (weak, nonatomic) IBOutlet UIImageView *userSexImgView;
@property (weak, nonatomic) IBOutlet UIView *commnetFathreView;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@property (nonatomic, assign) BOOL isComment; //是否点赞
@property (nonatomic, strong) EVOUserCommunityDataObj * dataObj;
@end

NS_ASSUME_NONNULL_END
