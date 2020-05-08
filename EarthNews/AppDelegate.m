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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self compareUserLoginStatus];
    
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
