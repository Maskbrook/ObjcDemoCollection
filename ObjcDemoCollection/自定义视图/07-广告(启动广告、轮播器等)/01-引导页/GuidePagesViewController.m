//
//  GuidePagesViewController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/3/26.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "GuidePagesViewController.h"
#import "GuidePageView.h"

@interface GuidePagesViewController ()

@end

@implementation GuidePagesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *showMenuButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    showMenuButton.backgroundColor = [UIColor magentaColor];
    [showMenuButton setTitle:@"show" forState:UIControlStateNormal];
    [self.view addSubview:showMenuButton];
    
    showMenuButton.actionBlock = ^{
        GuidePageView *guidePageView = [[GuidePageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) images:@[@"launch01", @"launch02", @"launch03", @"launch04"]];
        [[UIApplication sharedApplication].keyWindow addSubview:guidePageView];
    };
}

@end
