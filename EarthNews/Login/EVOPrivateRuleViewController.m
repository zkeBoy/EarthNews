//
//  EVOPrivateRuleViewController.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOPrivateRuleViewController.h"

@interface EVOPrivateRuleViewController ()
@property (nonatomic, strong) UIButton * submitBtn;
@end

@implementation EVOPrivateRuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MainBgColor;
    
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.bottom.equalTo(self.view).offset(-167);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(46);
    }];
}

#pragma mark - Private Method
- (void)clickCompleteAction {
    [[NSNotificationCenter defaultCenter] postNotificationName:EVOUserSignUpSuccessKey object:nil];
}

#pragma mark - lazy init
- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton new];
        _submitBtn.titleLabel.font = BFont(17);
        _submitBtn.layer.cornerRadius = 23;
        _submitBtn.layer.backgroundColor = UIColor.whiteColor.CGColor;
        [_submitBtn addTarget:self action:@selector(clickCompleteAction) forControlEvents:UIControlEventTouchUpInside];
        [_submitBtn setTitle:@"同意" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:MainBgColor forState:UIControlStateNormal];
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
