//
//  EVOMessageViewController.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/7.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOMessageViewController.h"

@interface EVOMessageViewController ()
@property (nonatomic, strong) UILabel * textTitleLabel;
@end

@implementation EVOMessageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MainBgColor;
    
    self.textTitleLabel = [UILabel new];
    self.textTitleLabel.text = @"通知";
    self.textTitleLabel.font = BFont(17);
    self.textTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.textTitleLabel.textColor = UIColor.whiteColor;
    [self.view addSubview:self.textTitleLabel];
    [self.textTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(kNavigationBarHeight+10);
    }];
    
    UIImageView * emptyImgView = [[UIImageView alloc] initWithImage:CreateImage(@"")];
    
    
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
