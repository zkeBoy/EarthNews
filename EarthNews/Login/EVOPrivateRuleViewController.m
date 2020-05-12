//
//  EVOPrivateRuleViewController.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOPrivateRuleViewController.h"
#import "EVOWebViewTool.h"
#import "EVOUserDataManager.h"

@interface EVOPrivateRuleViewController ()
@property (nonatomic, strong) UIButton * submitBtn;
@property (nonatomic, strong) UIView   * topView;
@end

@implementation EVOPrivateRuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topView = [UIView new];
    self.topView.backgroundColor = MainBgColor;
    self.topView.frame = CGRectMake(0, 0, kScreenWidth, kNavigationBarHeight+kStatusBarHeight);
    [self.view addSubview:self.topView];
    
    UIButton * backBtn = [UIButton new];
    [backBtn setImage:CreateImage(@"icon_back") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBackAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(24);
        make.bottom.equalTo(self.topView).offset(-14);
        make.width.mas_equalTo(9);
        make.height.mas_equalTo(18);
    }];
    
    UILabel * titleLabel = [UILabel new];
    titleLabel.textColor = UIColor.whiteColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = BFont(17);
    [self.topView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topView);
        make.bottom.equalTo(self.topView).offset(-14);
    }];
    
    CGRect frame = CGRectMake(0, kNavigationBarHeight+kStatusBarHeight, kScreenWidth, kScreenHeight-kNavigationBarHeight-kStatusBarHeight);
    if (self.type==RulePriveteType) {
        [EVOWebViewTool initWebViewPath:LocalFilePath(@"PrivacyPolicy", @"pdf") toView:self.view frame:frame];
        self.submitBtn.layer.backgroundColor = MainBgColor.CGColor;
        [self.submitBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        titleLabel.text = @"隐私政策";
    }else if (self.type==RuleServiceType){
        [EVOWebViewTool initWebViewPath:LocalFilePath(@"TermsOfUse", @"pdf") toView:self.view frame:frame];
        self.submitBtn.layer.backgroundColor = MainBgColor.CGColor;
        titleLabel.text = @"服务条款";
        [self.submitBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    }else {
        [EVOWebViewTool initWebViewPath:LocalFilePath(@"leadRule", @"pdf") toView:self.view frame:frame];
        self.submitBtn.layer.backgroundColor = UIColor.whiteColor.CGColor;
        titleLabel.text = @"社区规范";
        [self.submitBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    }
    
    self.view.backgroundColor = MainBgColor;
    
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.bottom.equalTo(self.view).offset(-107);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(46);
    }];
}

#pragma mark - Private Method
- (void)clickCompleteAction {
    if (self.isSetting) {
        [self clickBackAction];
    }else {
        [[EVOUserDataManager shareUserDataManager] saveUserData:[EVOUserDataManager shareUserDataManager].userDataObj];
        [[NSNotificationCenter defaultCenter] postNotificationName:EVOUserSignUpSuccessKey object:nil];
    }
}

- (void)clickBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - lazy init
- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton new];
        _submitBtn.titleLabel.font = BFont(17);
        _submitBtn.layer.cornerRadius = 23;
        _submitBtn.layer.backgroundColor = MainBgColor.CGColor;
        [_submitBtn addTarget:self action:@selector(clickCompleteAction) forControlEvents:UIControlEventTouchUpInside];
        [_submitBtn setTitle:@"同意" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    }
    return _submitBtn;
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
