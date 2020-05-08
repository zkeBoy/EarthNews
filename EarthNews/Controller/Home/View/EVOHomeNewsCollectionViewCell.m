//
//  EVOHomeNewsCollectionViewCell.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/7.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOHomeNewsCollectionViewCell.h"

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
    self.bgContentView.contentMode = UIViewContentModeScaleToFill;
}

- (void)setDataObj:(EVOUserCommunityDataObj *)dataObj {
    _dataObj = dataObj;
    NSArray * imgs = [dataObj.Image_1 componentsSeparatedByString:@";"];
    NSString * string = @"http://android-screenimgs.25pp.com/223/1561567_137633289902.jpg";
    if (imgs.count) {
        [self.bgContentView sd_setImageWithURL:[NSURL URLWithString:string] placeholderImage:nil];
    }
    
    self.newsAddressTextLabel.text = dataObj.Nation;
    self.newsContentTextLabel.text = dataObj.Intrduce;
}

@end
