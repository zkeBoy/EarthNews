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
        make.top.equalTo(self.view).offset(kStatusBarHeight+10);
    }];
    
    UIImageView * emptyImgView = [[UIImageView alloc] initWithImage:CreateImage(@"icon_empty")];
    [self.view addSubview:emptyImgView];
    [emptyImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(79);
        make.height.mas_equalTo(50);
        make.center.equalTo(self.view);
    }];
    
    UILabel * titleLabel = [UILabel new];
    titleLabel.text = @"你收到的点赞和评论会显示在这里";
    titleLabel.font = NFont(14);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = RGBHex(@"#353535");
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(emptyImgView.mas_bottom).offset(10);
    }];
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
