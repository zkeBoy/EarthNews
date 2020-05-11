//
//  EVOWebViewTool.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/9.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOWebViewTool.h"

@implementation EVOWebViewTool

+ (void)initWebViewPath:(NSString *)path toView:(UIView *)view frame:(CGRect)frame{
    EVOWebViewTool * webView = [[EVOWebViewTool alloc] initWithFrame:frame];
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    webView.path = path;
    [webView setUIConfig];
    [view addSubview:webView];
}

- (void)setUIConfig {
    WKWebViewConfiguration *webConfiguration = [WKWebViewConfiguration new];
    _webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds configuration:webConfiguration];
    NSString * urlStr = self.path;
    _webView.backgroundColor = MainBgColor;
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
    [self addSubview:_webView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
