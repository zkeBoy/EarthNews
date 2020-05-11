//
//  EVOWebViewTool.h
//  EarthNews
//
//  Created by zkeBoy on 2020/5/9.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <QuickLook/QuickLook.h>

NS_ASSUME_NONNULL_BEGIN

@interface EVOWebViewTool : UIView <UIWebViewDelegate>
@property (nonatomic, strong) WKWebView * webView;
@property (nonatomic,   copy) NSString  * path;
+ (void)initWebViewPath:(NSString *)path toView:(UIView *)view frame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
