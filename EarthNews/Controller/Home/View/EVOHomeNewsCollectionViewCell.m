//
//  EVOHomeNewsCollectionViewCell.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/7.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOHomeNewsCollectionViewCell.h"
#import "EVOCommunityDataManager.h"

@implementation EVOHomeNewsCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.contentView.layer.cornerRadius = 8;
        self.contentView.clipsToBounds = YES;
        self.contentView.layer.backgroundColor = UIColor.whiteColor.CGColor;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgContentView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setDataObj:(EVOUserCommunityDataObj *)dataObj {
    _dataObj = dataObj;
    NSArray * imgs = [dataObj.Image_1 componentsSeparatedByString:@";"];
    if (imgs.count) {
        [self.bgContentView sd_setImageWithURL:imgs.firstObject placeholderImage:nil];
    }
    
    self.newsAddressTextLabel.text = dataObj.Nation;
    self.newsContentTextLabel.text = dataObj.Intrduce;
}


- (IBAction)clickMoreAction:(id)sender {
    NSDictionary * dic = @{@"title":@"屏蔽",
                           @"color":RGBHex(@"#005FFF")
    };
    
    NSDictionary * dic1 = @{@"title":@"举报",
                           @"color":RGBHex(@"#FF3535")
    };
    
    NSArray * sections = @[dic,dic1];
    
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
        }
    } clickCancelBlock:nil];
}

@end
