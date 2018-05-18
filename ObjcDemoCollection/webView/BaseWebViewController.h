//
//  BaseWebViewController.h
//  ProtocolDelegateDemo
//
//  Created by jiabaozhang on 2018/5/18.
//  Copyright © 2018年 maskbrook. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WebViwewProtocol <NSObject>
//请求Url结果
- (void)requestWebUrlResult:(void(^)(BOOL succ, NSString *urlString))block;

@end

@interface BaseWebViewController : UIViewController

@property (nonnull, nonatomic, strong) __kindof UIView *webView;

- (instancetype)initWithNavTitle:(NSString *)navTitle webUrl:(NSString *)webUrl;

@end
