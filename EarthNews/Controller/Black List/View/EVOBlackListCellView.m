//
//  EVOBlackListCellView.m
//  EarthNews
//
//  Created by zkeBoy on 2020/6/11.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOBlackListCellView.h"
#import "EVOBlackListManager.h"

@implementation EVOBlackListCellView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setDataObj:(EVOUserCommunityDataObj *)dataObj {
    _dataObj = dataObj;
    [self.userHeadImgView sd_setImageWithURL:[NSURL URLWithString:dataObj.Image]];
    self.userNickNameLabel.text = dataObj.Name;
    self.userDescriptionLabel.text = dataObj.Intrduce;
}

- (IBAction)clickRemoveBlackListAction:(id)sender {
    [EVOBlackListManager deleteBlackItem:self.dataObj];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userHeadImgView.layer.cornerRadius = 23;
    self.userHeadImgView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
