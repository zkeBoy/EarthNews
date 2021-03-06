//
//  EVOCommunityViewCell.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/7.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOCommunityViewCell.h"
#import "EVOCommunityDataManager.h"
#import "EVOBlackListManager.h"

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
    self.timeTextLabel.hidden = YES;
    self.userSexImgView.hidden = YES;
}

- (void)addGestureRecognizers {
    WeakSelf(self);
    [self.commentBtn addTapActionWithBlock:^(UIGestureRecognizer * tap) {
        [WeakSelf clickCommentGoodAction];
    }];
    
    [self.privateMessageBtn addTapActionWithBlock:^(UIGestureRecognizer * tap) {
        [WeakSelf clickPriveteChatAction];
    }];
    
    [self.pictureOneImgView addTapActionWithBlock:^(UIGestureRecognizer * tap) {
        [WeakSelf showImgsBrowserPage:0];
    }];
    
    [self.pictureTwoImgView addTapActionWithBlock:^(UIGestureRecognizer * tap) {
        [WeakSelf showImgsBrowserPage:1];
    }];
    
    [self.pictureThreeImgView addTapActionWithBlock:^(UIGestureRecognizer * tap) {
        [WeakSelf showImgsBrowserPage:2];
    }];
}

- (void)setUIConfig {
    
    // Initialization code
    self.userHeadImgView.layer.cornerRadius = 17.5;
    
    self.userHeadImgView.contentMode = UIViewContentModeScaleToFill;
    
    self.pictureOneImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.pictureTwoImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.pictureThreeImgView.contentMode = UIViewContentModeScaleAspectFill;
    
    NSInteger space = (kScreenWidth-114*3-26)/2;
    
    self.spaceOne.constant = space;
    self.spaceThree.constant = space;
}

- (void)setDataObj:(EVOUserCommunityDataObj *)dataObj {
    _dataObj = dataObj;
    
    if (dataObj.isSelf.length) {
        self.commnetFathreView.hidden = YES;
        self.moreBtn.hidden = YES;
    }else {
        self.commnetFathreView.hidden = NO;
        self.moreBtn.hidden = NO;
    }
    
    if (dataObj.userHeadImg) {
        //个人发布的动态
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            UIImage * userImg = [YYImage imageWithData:dataObj.userHeadImg];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.userHeadImgView.image = userImg;
                //[self.userHeadImgView sd_setImageWithURL:nil placeholderImage:userImg];
            });
        });
        
        NSArray * imgs = dataObj.imgArray;
        
        if (imgs.count==1) {
            self.pictureOneImgView.hidden = NO;
            self.pictureThreeImgView.hidden = YES;
            self.pictureTwoImgView.hidden = YES;
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                UIImage * image = [YYImage imageWithData:imgs.firstObject scale:.05];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.pictureOneImgView.image = image;
                    //[self.pictureOneImgView sd_setImageWithURL:nil placeholderImage:image];
                });
            });
            
        }else if (imgs.count==2){
            self.pictureOneImgView.hidden = NO;
            self.pictureThreeImgView.hidden = YES;
            self.pictureTwoImgView.hidden = NO;
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                UIImage * image = [YYImage imageWithData:imgs.firstObject];
                UIImage * image2 = [YYImage imageWithData:imgs.lastObject];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.pictureOneImgView.image = image;
                    self.pictureTwoImgView.image = image2;
                });
            });
        }else {
            self.pictureOneImgView.hidden = NO;
            self.pictureThreeImgView.hidden = NO;
            self.pictureTwoImgView.hidden = NO;
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                UIImage * image = [YYImage imageWithData:imgs.firstObject];
                UIImage * image2 = [YYImage imageWithData:imgs[1]];
                UIImage * image3 = [YYImage imageWithData:imgs.lastObject];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.pictureOneImgView.image = image;
                    self.pictureTwoImgView.image = image2;
                    self.pictureTwoImgView.image = image3;
                });
            });
        }
        
    }else {
        [self.userHeadImgView sd_setImageWithURL:[NSURL URLWithString:dataObj.Image] placeholderImage:nil];
        
        NSArray * imgs = [dataObj.Image_1 componentsSeparatedByString:@";"];
        if (imgs.count) {
            if (imgs.count==1) {
                self.pictureOneImgView.hidden = NO;
                self.pictureThreeImgView.hidden = YES;
                self.pictureTwoImgView.hidden = YES;
                [self.pictureOneImgView sd_setImageWithURL:[NSURL URLWithString:imgs.firstObject] placeholderImage:nil];
            }else if (imgs.count==2){
                self.pictureOneImgView.hidden = NO;
                self.pictureThreeImgView.hidden = NO;
                self.pictureTwoImgView.hidden = YES;
                [self.pictureOneImgView sd_setImageWithURL:[NSURL URLWithString:imgs.firstObject] placeholderImage:nil];
                [self.pictureTwoImgView sd_setImageWithURL:[NSURL URLWithString:imgs[1]] placeholderImage:nil];
            }else {
                self.pictureOneImgView.hidden = NO;
                self.pictureThreeImgView.hidden = NO;
                self.pictureTwoImgView.hidden = NO;
                [self.pictureOneImgView sd_setImageWithURL:[NSURL URLWithString:imgs.firstObject] placeholderImage:nil];
                [self.pictureTwoImgView sd_setImageWithURL:[NSURL URLWithString:imgs[1]] placeholderImage:nil];
                [self.pictureThreeImgView sd_setImageWithURL:[NSURL URLWithString:imgs.lastObject] placeholderImage:nil];
            }
        }else {
            self.pictureOneImgView.hidden = YES;
            self.pictureThreeImgView.hidden = YES;
            self.pictureTwoImgView.hidden = YES;
        }
    }
    
    self.userNameTextLabel.text = dataObj.Name;
    self.descriptionTextLabel.text = dataObj.Intrduce;
    self.localAddressLabel.text = dataObj.Nation;
    self.timeTextLabel.text = dataObj.Age;
    
    if (dataObj.Gender.integerValue==1) {
        self.userSexImgView.image = CreateImage(@"icon_man");
    }else {
        self.userSexImgView.image = CreateImage(@"icon_woman");
    }
}

#pragma mark - Private Method
- (IBAction)clickMoreAction:(id)sender {
    NSDictionary * dic = @{@"title":@"屏蔽",
                           @"color":RGBHex(@"#005FFF")
    };
    
    NSDictionary * dic1 = @{@"title":@"举报",
                            @"color":RGBHex(@"#FF3535")
    };
    
    NSDictionary * dic2 = @{@"title":@"将此人加入黑名单",
                            @"color":RGBHex(@"#FF3535")};
    
    NSArray * sections = @[dic,dic1,dic2];
    
    [[EVONormalToolManager shareManager] showSectionTitles:sections message:nil selectHandler:^(NSInteger selectIndex) {
        if (selectIndex==0) {
            //屏蔽
            [[EVOCommunityDataManager shareCommunityDataManager] shieldOtherCommunityData:self.dataObj];
        }else if (selectIndex==1){
            //举报
            [self showToastText:@"举报成功!"];
        }else {
            //加入黑名单
            [self showToastText:@"加入黑名单成功!"];
            [EVOBlackListManager addBlackList:self.dataObj];
        }
    } clickCancelBlock:nil];
}

- (void)clickPriveteChatAction {//点击私信
    if (self.clickPrivateChatBlock) {
        self.clickPrivateChatBlock(self.dataObj);
    }
}

- (void)clickCommentGoodAction {//点赞
    /*
    if (self.isComment) {
        self.commentImgView.image = CreateImage(@"icon_good");
        self.commentTextLabel.text = @"点赞";
    }else {
        self.commentImgView.image = CreateImage(@"icon_good_sel");
        self.commentTextLabel.text = @"1";
    }
    self.isComment = !self.isComment;*/
    
    self.commentImgView.image = CreateImage(@"icon_good_sel");
    self.commentTextLabel.text = @"1";
    
    [[EVOCommunityDataManager shareCommunityDataManager] addGoodsOtherCommunityData:self.dataObj];
}

- (void)showImgsBrowserPage:(NSInteger)page {
    NSMutableArray * arr = [NSMutableArray array];
    if (self.dataObj.userHeadImg) {
        //本地图片
        NSArray * imgs = self.dataObj.normalImgArray;
        for (NSData * imgData in imgs) {
            //UIImage * image = [UIImage imageWithData:imgData];
            YBIBImageData *data1 = [YBIBImageData new];
            data1.imageData = ^NSData * _Nullable{
                return imgData;
            };
            data1.allowSaveToPhotoAlbum = NO;
            [arr addObject:data1];
        }
    }else {
        NSArray * imgs = [self.dataObj.Image_1 componentsSeparatedByString:@";"];
        for (NSString * imglink in imgs) {
            YBIBImageData *data1 = [YBIBImageData new];
            data1.imageURL = [NSURL URLWithString:imglink];
            data1.allowSaveToPhotoAlbum = NO;
            [arr addObject:data1];
        }
    }
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = arr;
    browser.currentPage = page;
    [browser show];
}

@end
