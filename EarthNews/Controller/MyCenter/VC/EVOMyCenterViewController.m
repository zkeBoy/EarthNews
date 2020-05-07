//
//  EVOMyCenterViewController.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/7.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOMyCenterViewController.h"
#import "EVOMyCenterTopView.h"

@interface EVOMyCenterViewController ()
@property (nonatomic, strong) EVOMyCenterTopView * topView;
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
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.height.mas_equalTo(230);
        make.top.equalTo(self.view).offset(kStatusBarHeight);
    }];
}

#pragma mark - lazy init
- (EVOMyCenterTopView *)topView {
    if (!_topView) {
        _topView = [EVOMyCenterTopView new];
    }
    return _topView;
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
