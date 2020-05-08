//
//  NSObject+Toast.h
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SVProgressHUD/SVProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Toast)
- (void)showToastText:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
