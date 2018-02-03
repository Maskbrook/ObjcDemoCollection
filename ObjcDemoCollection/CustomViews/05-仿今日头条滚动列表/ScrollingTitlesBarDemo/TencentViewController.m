//
//  TencentViewController.m
//  PPScrollingTagsDemo
//
//  Created by jiabaozhang on 17/5/15.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TencentViewController.h"
#import "ChildViewController.h"

@interface TencentViewController ()

@end

@implementation TencentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    // 添加子控制器
    [self setUpAllViewController];
    // 设置frame
    self.SetContentFrameBlock = ^void(UIView *contentView){
        CGFloat contentX = 40;
        CGFloat contentY = 100;
        CGFloat contentW = 300;
        CGFloat contentH = 300;
        contentView.frame = CGRectMake(contentX, contentY, contentW, contentH);
    };
    // 是否显示遮盖
    self.displayCoverView = true;
    // 是否显示底部指示器
//    self.displayUnderlineView = false;
}

// 添加所有子控制器
- (void)setUpAllViewController
{
    // 段子
    ChildViewController *wordVc1 = [[ChildViewController alloc] init];
    wordVc1.title = @"后端";
    [self addChildViewController:wordVc1];
    
    // 段子
    ChildViewController *wordVc2 = [[ChildViewController alloc] init];
    wordVc2.title = @"移动端";
    [self addChildViewController:wordVc2];
    
    // 段子
    ChildViewController *wordVc3 = [[ChildViewController alloc] init];
    wordVc3.title = @"前段";
    [self addChildViewController:wordVc3];
    
    ChildViewController *wordVc4 = [[ChildViewController alloc] init];
    wordVc4.title = @"热点新闻";
    [self addChildViewController:wordVc4];
    
    // 全部
    ChildViewController *allVc = [[ChildViewController alloc] init];
    allVc.title = @"全部";
    [self addChildViewController:allVc];
    
    // 视频
    ChildViewController *videoVc = [[ChildViewController alloc] init];
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    
    // 声音
    ChildViewController *voiceVc = [[ChildViewController alloc] init];
    voiceVc.title = @"声音";
    [self addChildViewController:voiceVc];
    
    // 图片
    ChildViewController *pictureVc = [[ChildViewController alloc] init];
    pictureVc.title = @"图片";
    [self addChildViewController:pictureVc];
    
    // 段子
    ChildViewController *wordVc = [[ChildViewController alloc] init];
    wordVc.title = @"段子";
    [self addChildViewController:wordVc];
}

@end
