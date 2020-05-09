//
//  EVOTabBarViewController.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/7.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOTabBarViewController.h"
#import "EVOHomeViewController.h"
#import "EVOMyCenterViewController.h"
#import "EVOCommunityViewController.h"
#import "EVOMessageViewController.h"
#import "EVODynamicsViewController.h"

@interface EVOTabBarViewController () <UITabBarControllerDelegate>

@end

@implementation EVOTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBarItemImageAction];
}

#pragma mark - 子控制器实现
- (void)setTabBarItemImageAction {
                           
    self.tabBar.translucent  = NO;
    self.tabBar.tintColor    = RGBHex(@"#1FA5E0");
    self.tabBar.barTintColor = RGBHex(@"#353535");
    self.delegate            = self;
    //去掉黑线
    if(@available(iOS 13.0, *)) {
        UITabBarAppearance * tabbarAppearance = self.tabBar.standardAppearance;
        tabbarAppearance.backgroundImage =
        [UIImage imageWithColor:UIColor.blackColor];
        tabbarAppearance.shadowImage = [UIImage imageWithColor:UIColor.blackColor];
        self.tabBar.standardAppearance = tabbarAppearance;
    }else{
        self.tabBar.backgroundImage = [UIImage imageWithColor:UIColor.blackColor];
        self.tabBar.shadowImage = [UIImage imageWithColor:UIColor.blackColor];
    }
    
    EVOHomeViewController * homeVC = [[EVOHomeViewController alloc]init];
    EVONavigationController *shouyeNavi = [[EVONavigationController alloc]initWithRootViewController:homeVC];
    
    EVOCommunityViewController * communityVC = [[EVOCommunityViewController alloc]init];
    EVONavigationController *communityNavi = [[EVONavigationController alloc]initWithRootViewController:communityVC];
    
    EVODynamicsViewController * dyNamicsVC = [EVODynamicsViewController new];
    EVONavigationController * dyNamicsNavi = [[EVONavigationController alloc]initWithRootViewController:dyNamicsVC];
    
    EVOMessageViewController * messgaeVC = [[EVOMessageViewController alloc]init];
    EVONavigationController * messageNavi = [[EVONavigationController alloc]initWithRootViewController:messgaeVC];
    
    EVOMyCenterViewController * myCenterVC = [[EVOMyCenterViewController alloc]init];
    EVONavigationController * myCenterNavi = [[EVONavigationController alloc]initWithRootViewController:myCenterVC];
    
    self.tabBarItemsAttributes = [self setTabBarItemsAttributes];
    self.viewControllers = @[shouyeNavi, communityNavi, dyNamicsNavi, messageNavi, myCenterNavi];
}

/// tabBar 属性数组
- (NSArray *)setTabBarItemsAttributes {
    
    NSDictionary *homeTabBarItemsAttributes = @{
        CYLTabBarItemTitle: @"探索",
        CYLTabBarItemImage: @"tab_Home",
        CYLTabBarItemSelectedImage: @"tab_Home_Sel",
    };
    NSDictionary *myCityTabBarItemsAttributes = @{
        CYLTabBarItemTitle: @"社区",
        CYLTabBarItemImage: @"tab_Community",
        CYLTabBarItemSelectedImage: @"tab_Community_Sel",
    };
    NSDictionary *dyNamicsTabBarItemsAttributes = @{
        CYLTabBarItemTitle: @"",
        CYLTabBarItemImage: @"tabDynamics",
        CYLTabBarItemSelectedImage: @"tabDynamics",
    };
    NSDictionary *messageTabBarItemsAttributes = @{
        CYLTabBarItemTitle: @"消息",
        CYLTabBarItemImage: @"tab_Message",
        CYLTabBarItemSelectedImage: @"tab_Message_Sel",
    };
    NSDictionary *accountTabBarItemsAttributes = @{
        CYLTabBarItemTitle: @"我的",
        CYLTabBarItemImage: @"tab_MyCenter",
        CYLTabBarItemSelectedImage: @"tab_MyCenter_Sel",
    };
    NSArray *tabBarItemsAttributes = @[
        homeTabBarItemsAttributes,
        myCityTabBarItemsAttributes,
        dyNamicsTabBarItemsAttributes,
        messageTabBarItemsAttributes,
        accountTabBarItemsAttributes
    ];
    return tabBarItemsAttributes;
}

#pragma mark - 点击tabbar触发的事件
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
}

#pragma mark - 判断tabbar是否跳转的相应事件
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (tabBarController.selectedIndex==2) {//点击发布
        return NO;
    }
    return YES;
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
