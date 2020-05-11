//
//  EVODynamicInfoView.m
//  EarthNews
//
//  Created by mr_huang on 2020/5/9.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVODynamicInfoView.h"
#import "SDCycleScrollView.h"
#import "EVOCommunityDataManager.h"

@interface EVODynamicInfoView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) UIImageView *backImg;

@property (nonatomic, strong) SDCycleScrollView *topScrollview;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIButton *likeBtn;

@property (nonatomic, strong) UIButton *commentsBtn;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UILabel *indexLabel;

@property (nonatomic, assign)NSInteger imgCount;
@end

@implementation EVODynamicInfoView
- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.bounds = CGRectMake(0, 0, 296, 323);//
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self addSubview:self.backImg];
    [self addSubview:self.topScrollview];
    [self addSubview:self.moreBtn];
    [self addSubview:self.contentLabel];
    [self addSubview:self.likeBtn];
    [self addSubview:self.commentsBtn];
    [self addSubview:self.indexLabel];
    [self.backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.topScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(7);
        make.top.equalTo(self.mas_top).offset(7);
        make.right.equalTo(self.mas_right).offset(-7);
        make.height.equalTo(@(200));
    }];
    
    [self.indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topScrollview.mas_right).offset(-9);
        make.bottom.equalTo(self.topScrollview.mas_bottom).offset(-7);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topScrollview.mas_right);
        make.top.equalTo(self.topScrollview.mas_top);
        make.size.mas_equalTo(CGSizeMake(33, 25));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.topScrollview);
        make.top.equalTo(self.topScrollview.mas_bottom).offset(10);
    }];
    [self.commentsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom).offset(-31);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.commentsBtn.mas_left).offset(-20);
        make.bottom.equalTo(self.mas_bottom).offset(-31);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
}


- (void)btnsOnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            {
                sender.selected = !sender.selected;
            }
            break;
        default:
            break;
    }
    if (self.btnsOnClickBlock) {
        self.btnsOnClickBlock(sender.tag);
    }
    
    [[EVOCommunityDataManager shareCommunityDataManager] addGoodsOtherCommunityData:self.dataObj];
}

//MARK: SET DATA
- (void)setInfoWithObj:(EVOUserCommunityDataObj *)obj
{
    self.dataObj = obj;
    //self.topScrollview.imageURLStringsGroup = obj;
    if (obj.userHeadImg) {
        //自己的动态
        NSArray * imgs = obj.normalImgArray;
        NSMutableArray * imgArra = [NSMutableArray new];
        for (NSData * imgData in imgs) {
            [imgArra addObject:[UIImage imageWithData:imgData]];
        }
        self.topScrollview.localizationImageNamesGroup = imgArra;
        self.imgCount = imgArra.count;
    }else {
        //他人动态
        NSArray * imgs = [obj.Image_1 componentsSeparatedByString:@";"];
        self.topScrollview.imageURLStringsGroup = imgs;
        self.imgCount = imgs.count;
    }
    self.indexLabel.text = [NSString stringWithFormat:@"1/%ld",(long)self.imgCount];
    self.contentLabel.text = obj.Intrduce;
}

//MARK: GETTER
- (UIImageView *)backImg
{
    if (!_backImg) {
        _backImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bubble"]];
        _backImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backImg;
}

- (SDCycleScrollView *)topScrollview
{
    if (!_topScrollview) {
        _topScrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@""]];
        _topScrollview.autoScroll = NO;
        _topScrollview.infiniteLoop = YES;
        _topScrollview.autoScroll = YES;
        _topScrollview.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        __weak typeof(self) weakSelf = self;
        _topScrollview.itemDidScrollOperationBlock = ^(NSInteger currentIndex) {
            weakSelf.indexLabel.text = [NSString stringWithFormat:@"%ld/%ld",currentIndex+1,weakSelf.imgCount];
        };
    }
    return _topScrollview;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textColor = RGBHex(@"#000000");
        _contentLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        _contentLabel.numberOfLines = 2;
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _contentLabel;
}

- (UIButton *)likeBtn
{
    if(!_likeBtn)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"点赞" forState:UIControlStateNormal];
        [btn setTitleColor:RGBHex(@"#000000") forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"like_black_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"like_black_selected"] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        [btn addTarget:self action:@selector(btnsOnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 0;
        CGFloat space = 5.0;
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0 - space / 2, 0, 0 + space / 2);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0 + space / 2, 0, 0 - space / 2);
        _likeBtn = btn;
    }
    return _likeBtn;
}
- (UIButton *)commentsBtn
{
    if(!_commentsBtn)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"评论" forState:UIControlStateNormal];
        [btn setTitleColor:RGBHex(@"#000000") forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"comments_block"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        [btn addTarget:self action:@selector(btnsOnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1;
        CGFloat space = 5.0;
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0 - space / 2, 0, 0 + space / 2);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0 + space / 2, 0, 0 - space / 2);
        _commentsBtn = btn;
    }
    return _commentsBtn;
}

- (UIButton *)moreBtn
{
    if(!_moreBtn)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"line_more"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnsOnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 2;
        _moreBtn = btn;
    }
    return _moreBtn;
}
- (UILabel *)indexLabel
{
    if (!_indexLabel) {
        _indexLabel = [UILabel new];
        _indexLabel.text = @"1/3";
        _indexLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightSemibold];
        _indexLabel.textColor = [UIColor whiteColor];
    }
    return _indexLabel;
}

//MARK: SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if (self.clickCommunityPictureBlock) {
        self.clickCommunityPictureBlock(self.dataObj, index);
    }
}

@end
