//
//  EVOBulletChatView.m
//  EarthNews
//
//  Created by mr_huang on 2020/5/9.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOBulletChatView.h"

@interface EVOBulletChatView ()
@property (nonatomic, strong) UIImageView *backView;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation EVOBulletChatView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 267, 50);
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self addSubview:self.backView];
    [self addSubview:self.headImg];
    [self addSubview:self.contentLabel];
    [self addSubview:self.nameLabel];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(5);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImg.mas_right).offset(5);
        make.top.equalTo(self.headImg.mas_top);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentLabel.mas_left);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(2);
    }];
}


- (void)setModel:(EVOBullevchatModel *)model
{
    _model = model;
    
    if (model.imageUrl) {
        [self.headImg sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:[UIImage imageNamed:@"default_head"]];
    } else {
        self.headImg.image = _model.image;
    }
    self.contentLabel.text = _model.content;
    self.nameLabel.text = _model.name;
}

//MARK: lazy

- (UIImageView *)backView
{
    if(!_backView)
    {
        _backView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bullet_chat"]];
    }
    return _backView;
}

- (UIImageView *)headImg
{
    if (!_headImg) {
        _headImg = [[UIImageView alloc]init];
        _headImg.contentMode = UIViewContentModeScaleAspectFill;
        _headImg.clipsToBounds = YES;
        _headImg.layer.cornerRadius = 20;
    }
    return _headImg;
}
- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        _contentLabel.textColor = [UIColor whiteColor];
    }
    return _contentLabel;
}
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        _nameLabel.textColor = RGBHexA(@"#FFFFFF", .6f);
    }
    return _nameLabel;
}
@end
