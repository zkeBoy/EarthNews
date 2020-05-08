//
//  EVOAppEnterViewController.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <SceneKit/SceneKit.h>
#import "EVOAppEnterViewController.h"
#import "GlobeScene.h"

@interface EVOAppEnterViewController ()
@property (weak, nonatomic) IBOutlet SCNView *sceneView;
@property (weak, nonatomic) IBOutlet UIButton *signUpBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@end

@implementation EVOAppEnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.blackColor;
    
    GlobeScene * gSCN = [[GlobeScene alloc] init];
    self.sceneView.scene = gSCN;
    self.sceneView.allowsCameraControl = YES; //是否可以手动放大
    self.sceneView.showsStatistics = NO; //是否显示帧率
    self.sceneView.backgroundColor = [UIColor blackColor];
    self.heightConstraint.constant = kScreenWidth;
    NSInteger top = 85;
    if (!isFullScreen) {
        top = 0.4*top;
    }
    self.topConstraint.constant = kStatusBarHeight+top;
    
    self.signUpBtn.layer.cornerRadius = 23;
    
}

#pragma mark - Private Method
- (IBAction)clickSignUpAction:(id)sender {
    
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
