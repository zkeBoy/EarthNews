//
//  EVOCommunityViewCell.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/7.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOCommunityViewCell.h"

@implementation EVOCommunityViewCell

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addGestureRecognizers];
    [self setUIConfig];
}

- (void)addGestureRecognizers {
    WeakSelf(self);
    [self.commentBtn addTapActionWithBlock:^(UIGestureRecognizer * tap) {
        [WeakSelf clickCommentGoodAction];
    }];
    
    [self.privateMessageBtn addTapActionWithBlock:^(UIGestureRecognizer * tap) {
        [WeakSelf clickPriveteChatAction];
    }];
}

- (void)setUIConfig {
    
    // Initialization code
    self.userHeadImgView.layer.cornerRadius = 17.5;
    
    NSInteger space = (kScreenWidth-114*3-26)/2;
    
    self.spaceOne.constant = space;
    self.spaceThree.constant = space;
}

- (void)setDataObj:(EVOUserCommunityDataObj *)dataObj {
    _dataObj = dataObj;
    [self.userHeadImgView sd_setImageWithURL:[NSURL URLWithString:dataObj.Image] placeholderImage:nil];
    
    self.userNameTextLabel.text = dataObj.Name;
    self.descriptionTextLabel.text = dataObj.Intrduce;
    self.localAddressLabel.text = dataObj.Nation;
    
    NSArray * imgs = [dataObj.Image_1 componentsSeparatedByString:@";"];
    if (imgs.count) {
        if (imgs.count==1) {
            self.pictureOneImgView.hidden = NO;
            self.pictureThreeImgView.hidden = YES;
            self.pictureTwoImgView.hidden = YES;
        }else if (imgs.count==2){
            self.pictureOneImgView.hidden = NO;
            self.pictureThreeImgView.hidden = NO;
            self.pictureTwoImgView.hidden = YES;
        }else {
            self.pictureOneImgView.hidden = NO;
            self.pictureThreeImgView.hidden = NO;
            self.pictureTwoImgView.hidden = NO;
        }
    }else {
        self.pictureOneImgView.hidden = YES;
        self.pictureThreeImgView.hidden = YES;
        self.pictureTwoImgView.hidden = YES;
    }
}

#pragma mark - Private Method
- (IBAction)clickMoreAction:(id)sender {
    
}

- (void)clickPriveteChatAction {//点击私信
    
}

- (void)clickCommentGoodAction {//点赞
    if (self.isComment) {
        self.commentImgView.image = CreateImage(@"icon_good");
        self.commentTextLabel.text = @"点赞";
    }else {
        self.commentImgView.image = CreateImage(@"icon_good_sel");
        self.commentTextLabel.text = @"1";
    }
    self.isComment = !self.isComment;
}
@end
