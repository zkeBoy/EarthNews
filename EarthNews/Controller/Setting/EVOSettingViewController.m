//
//  EVOSettingViewController.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOSettingViewController.h"
#import "EVOConnectUsViewController.h"
#import "EVOPrivateRuleViewController.h"
#import "EVOBlackListViewController.h"
#import "EVOUserDataManager.h"

@interface EVOSettingViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topNavBarHeight;

@end

@implementation EVOSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topNavBarHeight.constant = kStatusBarHeight+kNavigationBarHeight;
    
    self.view.backgroundColor = MainBgColor;
}

#pragma mark - Private Method
- (IBAction)logoutAction:(id)sender {//退出登录
    [[EVONormalToolManager shareManager] showAlertViewWithTitle:@"是否删除账号?" message:nil other:@"确定" cancel:@"取消" otherBlock:^{
        [[EVOUserDataManager shareUserDataManager] logOut];
    } cancelBlock:nil];
}

- (IBAction)connectUsAction:(id)sender {//联系我们
    EVOConnectUsViewController * connectUsVC = [[EVOConnectUsViewController alloc] initWithNibName:@"EVOConnectUsViewController" bundle:nil];
    [self.navigationController pushViewController:connectUsVC animated:YES];
}

- (IBAction)privateRuleAction:(id)sender {//隐私政策
    EVOPrivateRuleViewController * ruleVC = [EVOPrivateRuleViewController new];
    ruleVC.type = RulePriveteType;
    ruleVC.isSetting = YES;
    [self.navigationController pushViewController:ruleVC animated:YES];
}

- (IBAction)serviceAction:(id)sender {//服务条款
    EVOPrivateRuleViewController * ruleVC = [EVOPrivateRuleViewController new];
    ruleVC.type = RuleServiceType;
    ruleVC.isSetting = YES;
    [self.navigationController pushViewController:ruleVC animated:YES];
}

- (IBAction)clickBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickBlackListAction:(id)sender {
    EVOBlackListViewController * blackListVC = [[EVOBlackListViewController alloc] initWithNibName:@"EVOBlackListViewController" bundle:nil];
    [self.navigationController pushViewController:blackListVC animated:YES];
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
