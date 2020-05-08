//
//  EVOSettingViewController.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOSettingViewController.h"
#import "EVOUserDataManager.h"

@interface EVOSettingViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topNavBarHeight;

@end

@implementation EVOSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MainBgColor;
}

#pragma mark - Private Method
- (IBAction)logoutAction:(id)sender {//退出登录
    [[EVONormalToolManager shareManager] showAlertViewWithTitle:@"是否删除账号?" message:nil other:@"确定" cancel:@"取消" otherBlock:^{
        [[EVOUserDataManager shareUserDataManager] logOut];
    } cancelBlock:nil];
}

- (IBAction)connectUsAction:(id)sender {//联系我们

}

- (IBAction)privateRuleAction:(id)sender {//隐私政策

}

- (IBAction)serviceAction:(id)sender {//服务条款

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
