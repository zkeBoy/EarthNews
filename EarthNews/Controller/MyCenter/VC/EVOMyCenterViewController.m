//
//  EVOMyCenterViewController.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/7.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOMyCenterViewController.h"
#import "EVOMyCenterPhotoCollectionView.h"
#import "EVOMyCenterTopView.h"
#import "EVOSettingViewController.h"
#import "EVOUserInfoEditeViewController.h"

@interface EVOMyCenterViewController () <UIScrollViewDelegate, EVOMyCenterTopChangeSelectItemProtocol>
@property (nonatomic, strong) EVOMyCenterTopView * topView;
@property (nonatomic, strong) UIScrollView       * contentView;
@property (nonatomic, strong) EVOMyCenterPhotoCollectionView * myTravelCollectionView; //我的轨迹
@property (nonatomic, strong) EVOMyCenterPhotoCollectionView * myGoodsCollectionView;//我的点赞
@end

@implementation EVOMyCenterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MainBgColor;
    
    [self setUIConfig];
}

- (void)setUIConfig {
    UIView * statusBar = [UIView new];
    statusBar.backgroundColor = SecondBgColor;
    statusBar.frame = CGRectMake(0, 0, kScreenWidth, kStatusBarHeight);
    [self.view addSubview:statusBar];
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.height.mas_equalTo(230);
        make.top.equalTo(self.view).offset(kStatusBarHeight);
    }];
    
    [self.view addSubview:self.contentView];
    self.contentView.frame = CGRectMake(0, kStatusBarHeight+230, kScreenWidth, kScreenHeight-kTabBarHeight-kStatusBarHeight-230);
    
    [self.contentView addSubview:self.myTravelCollectionView];
    
    [self.contentView addSubview:self.myGoodsCollectionView];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x/kScreenWidth;
    [self.topView scrollCollectionViewChangePage:page];
}

#pragma mark - EVOMyCenterTopChangeSelectItemProtocol
- (void)changeSelectItem:(NSInteger)itemPage {
    [self.contentView setContentOffset:CGPointMake(itemPage*kScreenWidth, 0) animated:YES];
}

- (void)clickEditeUserInfoAction {//点击编辑用户
    EVOUserInfoEditeViewController * editeVC = [[EVOUserInfoEditeViewController alloc] initWithNibName:@"EVOUserInfoEditeViewController" bundle:nil];
    editeVC.isSignUp = NO;
    [self.navigationController pushViewController:editeVC animated:YES];
}

- (void)clickSettingAction {//点击设置用户
    EVOSettingViewController * settingVC = [[EVOSettingViewController alloc] initWithNibName:@"EVOSettingViewController" bundle:nil];
    [self.navigationController pushViewController:settingVC animated:YES];
}

#pragma mark - lazy init
- (EVOMyCenterTopView *)topView {
    if (!_topView) {
        _topView = [EVOMyCenterTopView new];
        _topView.delegate = self;
    }
    return _topView;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _contentView.contentSize = CGSizeMake(kScreenWidth*2, kScreenHeight-kTabBarHeight-kStatusBarHeight-230);
        _contentView.pagingEnabled = YES;
        _contentView.delegate = self;
    }
    return _contentView;
}

- (EVOMyCenterPhotoCollectionView *)myTravelCollectionView {
    if (!_myTravelCollectionView) {
        _myTravelCollectionView = [[EVOMyCenterPhotoCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight-kStatusBarHeight-230)];
        _myTravelCollectionView.itemCount = 12;
    }
    return _myTravelCollectionView;
}

- (EVOMyCenterPhotoCollectionView *)myGoodsCollectionView {
    if (!_myGoodsCollectionView) {
        _myGoodsCollectionView = [[EVOMyCenterPhotoCollectionView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight-kTabBarHeight-kStatusBarHeight-230)];
        _myGoodsCollectionView.itemCount = 10;
    }
    return _myGoodsCollectionView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
