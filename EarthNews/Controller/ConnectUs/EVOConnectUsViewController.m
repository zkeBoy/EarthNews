//
//  EVOConnectUsViewController.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/9.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOConnectUsViewController.h"
#import "UITextView+YLTextView.h"

@interface EVOConnectUsViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeightConstraint;
@property (weak, nonatomic) IBOutlet UITextField *emailInputView;
@property (weak, nonatomic) IBOutlet UITextView *contentInputView;

@end

@implementation EVOConnectUsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainBgColor;
    self.topHeightConstraint.constant = kStatusBarHeight+kNavigationBarHeight;
    
    UIColor *color = RGBHex(@"#969696");
    self.emailInputView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"你的邮箱" attributes:@{NSForegroundColorAttributeName: color}];
    
    self.contentInputView.placeholder = @"描述你在使用过程中遇到的问题…";
    self.contentInputView.placeholdFont = BFont(16);
    self.contentInputView.placeholdColor = color;
    self.contentInputView.limitLength = @(140);
}

#pragma mark - Private Method

- (IBAction)clickBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickCompleteAction:(id)sender {
    
    if (!self.emailInputView.text.length) {
        [self showToastText:@"请输入你的邮箱!"];
        return;
    }
    
    if (![[EVONormalToolManager shareManager] isEmail:self.emailInputView.text]) {
        [self showToastText:@"请输入正确邮箱!"];
        return;
    }
    
    if (!self.contentInputView.text.length) {
        [self showToastText:@"请输入描述!"];
        return;
    }
    
    NSString * email = self.emailInputView.text;
    
    NSString * content = self.contentInputView.text;
    
    [self clickBackAction:nil];
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
