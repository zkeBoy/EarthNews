//
//  AppDelegate.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/7.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "AppDelegate.h"
#import "EVOAppEnterViewController.h"
#import "EVOTabBarViewController.h"
#import "EVOUserDataManager.h"

@interface AppDelegate ()<OpenInstallDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [OpenInstallSDK initWithDelegate:self];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //完成注册
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exchangeTabBarToRootVC) name:EVOUserSignUpSuccessKey object:nil];
    
    //退出登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(compareUserLoginStatus) name:EVOUserLogOutSuccessKey object:nil];
    //判断是否登录
    if ([[EVOUserDataManager shareUserDataManager] isLogin]) {
        [self exchangeTabBarToRootVC];
    }else {
        [self compareUserLoginStatus];
    }
    
    //MARK:定位相关
    [[EVOLocation shareInstance] registerLocationAMap];
    [[EVOLocation shareInstance] getUserLocationAddress];
    
    return YES;
}

- (void)compareUserLoginStatus { //判断用户登录状态
    EVOAppEnterViewController * appEnterVC = [[EVOAppEnterViewController alloc] initWithNibName:@"EVOAppEnterViewController" bundle:nil];
    EVONavigationController * nav = [[EVONavigationController alloc] initWithRootViewController:appEnterVC];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}

- (void)exchangeTabBarToRootVC {
    EVOTabBarViewController * rootVC = [EVOTabBarViewController new];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
}

@end
