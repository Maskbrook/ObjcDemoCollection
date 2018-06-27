//
//  BaseWebViewController.m
//  ProtocolDelegateDemo
//
//  Created by jiabaozhang on 2018/5/18.
//  Copyright © 2018年 maskbrook. All rights reserved.
//

#import "BaseWebViewController.h"
#import <WebKit/WebKit.h>
#import <Masonry.h>
#import <MBProgressHUD.h>

@interface BaseWebViewController ()<UIWebViewDelegate, WKNavigationDelegate>

@property (nonatomic ,copy) NSString *navTitle;
@property (nonatomic ,copy) NSString *webUrl;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation BaseWebViewController

- (instancetype)initWithNavTitle:(NSString *)navTitle webUrl:(NSString *)webUrl
{
    if (self = [super init]) {
        _navTitle = navTitle;
        _webUrl = webUrl;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutPageSubviews];
    [self loadWebUrlResult];
}

#pragma mark - private methods
- (void)loadWebUrlResult
{
    WS(weakSelf);
    if ([self conformsToProtocol:@protocol(WebViwewProtocol)]) {
        [(id <WebViwewProtocol>)self requestWebUrlResult:^(BOOL succ, NSString *urlString) {
            if (succ) {
                weakSelf.webUrl = urlString;
                [weakSelf launchRequest];
            }
        }];
    }
}

- (void)launchRequest
{
    [(WKWebView *)self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
}

#pragma mark - layout pageSubviews
- (void)layoutPageSubviews
{
    [self.view addSubview:(WKWebView *)self.webView];
    CGFloat bottomOffset = iPhoneX ? 88 : 64;
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(bottomOffset);
    }];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
//    if (StringIsNullOrEmpty(self.navTitle)) {
//        [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//            if ([result isKindOfClass:[NSString class]]) {
//                self.title = result;
//            }
//        }];
//        return;
//    }
//
//    self.navigationItem.title = self.navTitle;
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    if (StringIsNullOrEmpty(self.navTitle)) {
//        self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    }
}

#pragma mark - getters
- (UIView *)webView
{
    if (_webView == nil) {
        _webView = [[WKWebView alloc] init];
        _webView.backgroundColor = [UIColor redColor];
        if ([_webView respondsToSelector:@selector(setNavigationDelegate:)]) {
            [_webView setNavigationDelegate: self];
        }
        if ([_webView respondsToSelector:@selector(setDelegate:)]) {
            [_webView setDelegate:self];
        }
    }
    return _webView;
}

@end
