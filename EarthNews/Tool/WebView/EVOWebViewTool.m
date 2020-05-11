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
    /*
    WKWebViewConfiguration *webConfiguration = [WKWebViewConfiguration new];
    _webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds configuration:webConfiguration];
    NSString * urlStr = self.path;
    _webView.backgroundColor = MainBgColor;
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
    [self addSubview:_webView];*/
    
    NSURL *url = [NSURL fileURLWithPath:self.path];
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.bounds;
    webView.backgroundColor = [UIColor whiteColor];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [webView sizeToFit];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    [self addSubview:webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
    NSString *javascript = [NSString stringWithFormat:@"var script = document.createElement('script');"
                            "script.type = 'text/javascript';"
                            "script.text = \"function ResizeImages() { "
                            "var myimg;"
                            "var maxwidth=%f;" //缩放系数
                            "for(i=0;i <document.images.length;i++){"
                            "myimg = document.images[i];"
                            "if(myimg.width > maxwidth){"
                            "var scale = myimg.width/myimg.height;"
                            "myimg.width = maxwidth;"
                            "myimg.height = maxwidth/scale;"
                            "}"
                            "}"
                            "}\";"
                            "document.getElementsByTagName('head')[0].appendChild(script);",CGRectGetWidth(webView.frame)];
    [webView stringByEvaluatingJavaScriptFromString:javascript];
 
    //添加调用JS执行的语句
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
