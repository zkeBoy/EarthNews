//
//  EVOMyCenterPhotoViewCell.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOMyCenterPhotoViewCell.h"

@implementation EVOMyCenterPhotoViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentImgView.backgroundColor = UIColor.whiteColor;
    self.contentImgView.contentMode = UIViewContentModeScaleToFill;
}

- (void)setUserDataObj:(EVOUserCommunityDataObj *)userDataObj {
    _userDataObj = userDataObj;
    if (userDataObj.imgArray.count) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            UIImage * image = [UIImage imageWithData:userDataObj.imgArray.firstObject scale:0.5];
            self.contentImgView.image = image;
        });
    }else {
        NSArray * arr = [userDataObj.Image_1 componentsSeparatedByString:@";"];
        if (arr.count) {
            [self.contentImgView sd_setImageWithURL:[NSURL URLWithString:arr.firstObject]];
        }
    }
    self.localAddressTextLabel.text = userDataObj.Nation;
}

- (IBAction)clickDeleteCommunityAction:(id)sender {
    if (self.clickDeleteMyCommunityBlock) {
        self.clickDeleteMyCommunityBlock(self.userDataObj);
    }
}

@end
