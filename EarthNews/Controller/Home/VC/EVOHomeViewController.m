//
//  EVOHomeViewController.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/7.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOHomeViewController.h"
#import "EVOHomeNewsListView.h"
#import "EVOMapDetailViewController.h"
#import <SceneKit/SceneKit.h>
#import "GlobeScene.h"
#import <Masonry.h>

@interface EVOHomeViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sceneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (weak, nonatomic) IBOutlet SCNView *sceneView;
@property (nonatomic, strong) UILabel * titleTextLabel;
@property (nonatomic, strong) EVOHomeNewsListView * newsListView;
@end

@implementation EVOHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.titleTextLabel = [UILabel new];
    self.titleTextLabel.text = @"地球新闻";
    self.titleTextLabel.font = [UIFont boldSystemFontOfSize:17];
    self.titleTextLabel.textColor = UIColor.whiteColor;
    self.titleTextLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.titleTextLabel];
    [self.titleTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(kStatusBarHeight+10);
    }];
    
    GlobeScene * gSCN = [[GlobeScene alloc] init];
    self.sceneView.scene = gSCN;
    self.sceneView.allowsCameraControl = YES; //是否可以手动放大
    self.sceneView.showsStatistics = NO; //是否显示帧率
    self.sceneView.backgroundColor = [UIColor blackColor];
    self.sceneHeight.constant = kScreenWidth;
    NSInteger top = 100;
    if (!isFullScreen) {
        top = 0.4*top;
    }
    self.top.constant = kStatusBarHeight+top;
    
    WeakSelf(self);
    self.newsListView = [[EVOHomeNewsListView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight+top+kScreenWidth+18, kScreenWidth, 172)];
    [self.view addSubview:self.newsListView];
    
}

#pragma mark - 跳转地图详情
- (void)clickToMapDetailAction {
    
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
