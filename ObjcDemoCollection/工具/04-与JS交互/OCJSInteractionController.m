//
//  OCJSInteractionController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/3/23.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "OCJSInteractionController.h"
#import <WebViewJavascriptBridge.h>

@interface OCJSInteractionController ()<UIWebViewDelegate>

@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIButton *getUserInfo;
@property (nonatomic, strong) UIButton *insertImage;

@end

@implementation OCJSInteractionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self layoutPageSubviews];
}

#pragma mark - private
- (void)layoutPageSubviews
{
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(self.view).with.insets(UIEdgeInsetsMake(100, 10, 200, 10));
    }];
    
    [self.view addSubview:self.getUserInfo];
    [self.getUserInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(44);
        make.left.mas_equalTo(self.view).offset(20);
        make.bottom.mas_equalTo(self.view).offset(-50);
    }];
    
    [self.view addSubview:self.insertImage];
    [self.insertImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(44);
        make.right.mas_equalTo(self.view).offset(-20);
        make.bottom.mas_equalTo(self.view).offset(-50);
    }];
    
    // 加载网页
    NSString *indexPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString *appHtml = [NSString stringWithContentsOfFile:indexPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseUrl = [NSURL fileURLWithPath:indexPath];
    [self.webView loadHTMLString:appHtml baseURL:baseUrl];
    
    // 开启日志
    [WebViewJavascriptBridge enableLogging];
    
    [self jsOpenOCAlbum];
    [self jsCallActionSheet];
}

#pragma mark - OC调用JS
- (void)OCGetJsUserInfo
{
    [self.bridge callHandler:@"getUserInfo" data:nil responseCallback:^(id responseData) {
        NSString *userInfo = [NSString stringWithFormat:@"%@,姓名:%@,年龄:%@", responseData[@"userID"], responseData[@"userName"], responseData[@"age"]];
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"从网页端获取的用户信息" message:userInfo preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [vc addAction:cancelAction];
        [vc addAction:okAction];
        [self presentViewController:vc animated:YES completion:nil];
    }];
}

- (void)OCGetJsInsertImage
{
    NSDictionary *dict = @{
                           @"url" : @"https://gss2.bdstatic.com/-fo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike116%2C5%2C5%2C116%2C38/sign=049102e10af431ada8df4b6b2a5fc7ca/77c6a7efce1b9d164bdc7d12f5deb48f8c5464ae.jpg",
                           };
    [self.bridge callHandler:@"insertImgToWebPage" data:dict responseCallback:^(id responseData) {
        NSLog(@"======");
    }];
}

#pragma mark - JS调用OC
- (void)jsOpenOCAlbum
{
    [self.bridge registerHandler:@"openAlbum" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"拿到了%@张%@的照片", data[@"count"], data[@"username"]);
        UIImagePickerController *imageVC = [[UIImagePickerController alloc] init];
        imageVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imageVC animated:YES completion:nil];
    }];
}

- (void)jsCallActionSheet
{
    [self.bridge registerHandler:@"callActionSheet" handler:^(id data, WVJBResponseCallback responseCallback) {
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"Message" message:@"This message is no accurate, so you need to rely on yourself." preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [vc addAction:cancelAction];
        [vc addAction:okAction];
        [self presentViewController:vc animated:YES completion:nil];
    }];
}

#pragma mark - getters
- (WebViewJavascriptBridge *)bridge
{
    if (_bridge == nil) {
        _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
        [_bridge setWebViewDelegate:self];
    }
    return _bridge;
}

- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
        _webView.backgroundColor = [UIColor lightGrayColor];
    }
    return _webView;
}

- (UIButton *)getUserInfo
{
    if (_getUserInfo == nil) {
        _getUserInfo = [[UIButton alloc] init];
        _getUserInfo.backgroundColor = [UIColor orangeColor];
        [_getUserInfo addTarget:self action:@selector(OCGetJsUserInfo) forControlEvents:UIControlEventTouchUpInside];
        [_getUserInfo setTitle:@"从JS获取用户信息" forState:UIControlStateNormal];
    }
    return _getUserInfo;
}

- (UIButton *)insertImage
{
    if (_insertImage == nil) {
        _insertImage = [[UIButton alloc] init];
        _insertImage.backgroundColor = [UIColor orangeColor];
        [_insertImage addTarget:self action:@selector(OCGetJsInsertImage) forControlEvents:UIControlEventTouchUpInside];
        [_insertImage setTitle:@"插入图片" forState:UIControlStateNormal];
    }
    return _insertImage;
}

@end
