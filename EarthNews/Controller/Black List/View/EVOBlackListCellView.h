//
//  EVOBlackListCellView.h
//  EarthNews
//
//  Created by zkeBoy on 2020/6/11.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EVOUserCommunityDataObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface EVOBlackListCellView : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNickNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImgView;
@property (nonatomic, strong) EVOUserCommunityDataObj * dataObj;
@end

NS_ASSUME_NONNULL_END
