//
//  BaiduWebViewController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/5/18.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "BaiduWebViewController.h"

@protocol TestProtocol
@required
- (void)buzzBeater;
@optional
- (void)thatManAgain;
@end


@interface BaiduWebViewController () <WebViwewProtocol, TestProtocol>

@end

@implementation BaiduWebViewController

- (void)buzzBeater
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Buzz Beater" message:@"Lets go home lets go home" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK Action");
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self conformsToProtocol:@protocol(TestProtocol)]) {
        [(id<TestProtocol>)self buzzBeater];
    }
}

- (void)requestWebUrlResult:(void (^)(BOOL, NSString *))block
{
    NSString *url = @"https://www.baidu.com";
    block(YES, url);
}

@end
