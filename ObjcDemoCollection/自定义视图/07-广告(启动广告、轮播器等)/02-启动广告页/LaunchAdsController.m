//
//  LaunchAdsController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/3/26.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "LaunchAdsController.h"
#import "LaunchAdView.h"

@interface LaunchAdsController ()

@property (nonatomic, strong) LaunchAdView *launchView;

@end

@implementation LaunchAdsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WS(weakSelf)
    
    //
    UIButton *countButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 140, 50)];
    countButton.backgroundColor = [UIColor magentaColor];
    [countButton setTitle:@"show button" forState:UIControlStateNormal];
    [self.view addSubview:countButton];
    countButton.actionBlock = ^{
        NSLog(@"====show loading page====");
        weakSelf.launchView = [[LaunchAdView alloc] initWithFrame:self.view.bounds];
        weakSelf.launchView.duration = 5.0;
        weakSelf.launchView.type = LaunchTypeCountButton;
        [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.launchView];
    };
    
    //
    UIButton *countCircle = [[UIButton alloc] initWithFrame:CGRectMake(200, 100, 140, 50)];
    countCircle.backgroundColor = [UIColor magentaColor];
    [countCircle setTitle:@"show circle" forState:UIControlStateNormal];
    [self.view addSubview:countCircle];
    countCircle.actionBlock = ^{
        NSLog(@"====show loading page====");
        weakSelf.launchView = [[LaunchAdView alloc] initWithFrame:self.view.bounds];
        weakSelf.launchView.duration = 5.0;
        weakSelf.launchView.type = LaunchTypeCircle;
        [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.launchView];
    };
}

@end
