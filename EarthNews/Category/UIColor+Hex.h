//
//  UIColor+Hex.h
//  EasyScan
//
//  Created by zkeBoy on 2020/5/6.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(double)alpha;

@end

NS_ASSUME_NONNULL_END
