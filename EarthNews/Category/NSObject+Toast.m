//
//  NSObject+Toast.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "NSObject+Toast.h"

@implementation NSObject (Toast)

- (void)showToastText:(NSString *)title {
    [self showToast:title withDelay:1];
}

- (void)showToast:(NSString *)title withDelay:(NSTimeInterval)duration {
    [SVProgressHUD showWithStatus:title];
    [SVProgressHUD dismissWithDelay:duration];
}

@end
