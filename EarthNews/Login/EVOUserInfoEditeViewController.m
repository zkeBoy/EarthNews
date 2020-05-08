//
//  EVOUserInfoEditeViewController.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOUserInfoEditeViewController.h"

@interface EVOUserInfoEditeViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navBarHeightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImgView;
@property (weak, nonatomic) IBOutlet UITextField *userNameInputView;
@property (weak, nonatomic) IBOutlet UILabel *userSexTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *userBrithdayTextLabel;

@property (nonatomic, strong) UIImage * headImg;
@end

@implementation EVOUserInfoEditeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainBgColor;
    self.navBarHeightConstraint.constant = kStatusBarHeight+kNavigationBarHeight;
    self.userHeadImgView.layer.cornerRadius = 30;
}

#pragma mark - Private Method
- (IBAction)clickBackAction:(id)sender {//点击返回
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickSubmitAction:(id)sender {//点击完成
    //判断数据是否完整
    if (!self.headImg) {
        
    }
    
    if (self.isSignUp) {
        [[NSNotificationCenter defaultCenter] postNotificationName:EVOUserSignUpSuccessKey object:nil];
    }
    [self clickBackAction:nil];
}

- (IBAction)selectUserHeadImgAction:(id)sender {
    //选择头像
    [[EVONormalToolManager shareManager] takePhotoAlbumImage:^(UIImage * _Nonnull image) {
        self.userHeadImgView.image = image;
        self.headImg = image;
    }];
}

- (IBAction)selectUserSexAction:(id)sender {
    //选择性别
    NSDictionary * man = @{@"title":@"男",
                           @"color":RGBHexA(@"#005FFF", 0.74)
    };
    NSDictionary * woMan = @{@"title":@"女",
                             @"color":RGBHexA(@"#FF3535", 0.82)
    };
    NSArray * sections = @[man,woMan];
    [[EVONormalToolManager shareManager] showSectionTitles:sections message:nil selectHandler:^(NSInteger selectIndex) {
        NSDictionary * dic = sections[selectIndex];
        NSString * title = dic[@"title"];
        self.userSexTextLabel.text = title;
    } clickCancelBlock:^{
        
    }];
}

- (IBAction)selectBirthDayAction:(id)sender {
    //选择生日
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
