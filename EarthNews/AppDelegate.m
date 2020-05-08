//
//  AppDelegate.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/7.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "AppDelegate.h"
#import "EVOAppEnterViewController.h"

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
    self.window.rootViewController = appEnterVC;
    [self.window makeKeyAndVisible];
}

@end
