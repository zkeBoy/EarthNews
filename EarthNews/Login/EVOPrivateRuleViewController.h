//
//  EVOPrivateRuleViewController.h
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RuleType) {
    RulePriveteType, //隐私政策
    RuleServiceType  //服务条款
};

NS_ASSUME_NONNULL_BEGIN

@interface EVOPrivateRuleViewController : UIViewController
@property (nonatomic, assign) RuleType type;
@property (nonatomic, assign) BOOL isSetting;
@end

NS_ASSUME_NONNULL_END
