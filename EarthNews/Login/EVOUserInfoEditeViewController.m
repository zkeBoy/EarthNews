//
//  EVOUserInfoEditeViewController.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOUserInfoEditeViewController.h"
#import "SPDateTimePickerView.h"

@interface EVOUserInfoEditeViewController () <SPDateTimePickerViewDelegate>
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
        [self showToastText:@"请上传头像!"];
        return;
    }
    
    if (self.userNameInputView.text.length==0) {
        [self showToastText:@"请输入个人昵称!"];
        return;
    }else {
        if (self.userNameInputView.text.length>10) {
            [self showToastText:@"请输入小于10字符昵称!"];
            return;
        }else {
            if ([[EVONormalToolManager shareManager] isEmptyWithString:self.userNameInputView.text]) {
                [self showToastText:@"请输入非空字符!"];
                return;
            }
        }
    }
    
    if (!self.userSexTextLabel.text.length) {
        [self showToastText:@"请选择用户性别!"];
        return;
    }
    
    if (!self.userBrithdayTextLabel.text.length) {
        [self showToastText:@"请选择用户生日!"];
        return;
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
    SPDateTimePickerView *pickerView = [[SPDateTimePickerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height) pickMode:SPDatePickerModeDate];
    pickerView.delegate = self;
    pickerView.title = @"时间选择器";
    [self.view addSubview:pickerView];
    [pickerView showDateTimePickerView];
}

#pragma mark - SPDateTimePickerViewDelegate
- (void)didClickFinishDateTimePickerView:(NSString*)date {
    self.userBrithdayTextLabel.text = date;
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
