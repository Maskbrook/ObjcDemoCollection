//
//  BaiduWebViewController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/5/18.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "BaiduWebViewController.h"

@interface BaiduWebViewController () <WebViwewProtocol>

@end

@implementation BaiduWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)requestWebUrlResult:(void (^)(BOOL, NSString *))block
{
    NSString *url = @"https://www.baidu.com";
    block(YES, url);
}

@end
