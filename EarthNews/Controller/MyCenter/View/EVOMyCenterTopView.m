//
//  EVOMyCenterTopView.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/7.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOMyCenterTopView.h"

@implementation EVOMyCenterTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUIConfig];
    }
    return self;
}

- (void)setUIConfig {
    self.textTitleLabel = [UILabel new];
    self.textTitleLabel.text = @"用户昵称";
    self.textTitleLabel.textColor = UIColor.whiteColor;
    self.textTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.textTitleLabel.font = BFont(17);
    [self addSubview:self.textTitleLabel];
    [self.textTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(10);
    }];
    
    self.userHeadImgView = [UIImageView new];
    self.userHeadImgView.layer.cornerRadius = 37;
    self.userHeadImgView.layer.backgroundColor = UIColor.whiteColor.CGColor;
    [self addSubview:self.userHeadImgView];
    [self.userHeadImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(74);
        make.left.equalTo(self).offset(24);
        make.top.equalTo(self).offset(63);
    }];
    
    self.editeUserBtn = [UIButton new];
    [self.editeUserBtn setImage:[UIImage imageNamed:@"user_edite"] forState:UIControlStateNormal];
    [self.editeUserBtn addTarget:self action:@selector(clickEditeUserInfoAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.editeUserBtn];
    [self.editeUserBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(22);
        make.bottom.equalTo(self.userHeadImgView.mas_bottom);
        make.right.equalTo(self.userHeadImgView.mas_right);
    }];
    
    self.settingBtn = [UIButton new];
    [self.settingBtn setImage:CreateImage(@"icon_setting") forState:UIControlStateNormal];
    [self.settingBtn addTarget:self action:@selector(clickSettingAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.settingBtn];
    [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(self.textTitleLabel.mas_centerY);
    }];
    
    self.getGoodsView = [EVOMyCenterCustomView new];
    self.getGoodsView.numberLabel.text = @"0";
    self.getGoodsView.textTitleLabel.text = @"获赞";
    [self addSubview:self.getGoodsView];
    [self.getGoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(36);
        make.height.mas_equalTo(48);
        make.top.equalTo(self.textTitleLabel.mas_bottom).offset(34);
        make.left.equalTo(self.userHeadImgView.mas_right).offset(45);
    }];
    
    self.followView = [EVOMyCenterCustomView new];
    self.followView.numberLabel.text = @"0";
    self.followView.textTitleLabel.text = @"关注";
    [self addSubview:self.followView];
    [self.followView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(36);
        make.height.mas_equalTo(48);
        make.top.equalTo(self.textTitleLabel.mas_bottom).offset(34);
        make.left.equalTo(self.getGoodsView.mas_right).offset(50);
    }];
    
    self.myFansView = [EVOMyCenterCustomView new];
    self.myFansView.numberLabel.text = @"0";
    self.myFansView.textTitleLabel.text = @"粉丝";
    [self addSubview:self.myFansView];
    [self.myFansView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(36);
        make.height.mas_equalTo(48);
        make.top.equalTo(self.textTitleLabel.mas_bottom).offset(34);
        make.left.equalTo(self.followView.mas_right).offset(50);
    }];
    
    self.localAdderssImgView = [UIImageView new];
    self.localAdderssImgView.image = CreateImage(@"icon_local");
    [self addSubview:self.localAdderssImgView];
    [self.localAdderssImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(9);
        make.height.mas_equalTo(12);
        make.left.equalTo(self.userHeadImgView.mas_right).offset(45);
        make.top.equalTo(self.followView.mas_bottom).offset(23);
    }];
    
    self.localAddressLabel = [UILabel new];
    self.localAddressLabel.text = @"北京";
    self.localAddressLabel.textColor = RGBHex(@"7F7F7F");
    self.localAddressLabel.font = NFont(12);
    [self addSubview:self.localAddressLabel];
    [self.localAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.localAdderssImgView.mas_centerY);
        make.left.equalTo(self.localAdderssImgView.mas_right).offset(4);
    }];
}

#pragma mark - Private Method
- (void)clickEditeUserInfoAction {
    
}

- (void)clickSettingAction {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
