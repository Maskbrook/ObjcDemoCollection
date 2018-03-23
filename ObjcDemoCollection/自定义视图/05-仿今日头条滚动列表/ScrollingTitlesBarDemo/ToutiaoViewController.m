//
//  ToutiaoViewController.m
//  PPScrollingTagsDemo
//
//  Created by jiabaozhang on 17/5/16.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "ToutiaoViewController.h"
#import "ChildViewController.h"
#import "UIView+Frame.h"

@interface ToutiaoViewController ()

@end

@implementation ToutiaoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    // 添加子控制器
    [self setUpAllViewController];
    // 设置frame
    __typeof(self) weakSelf = self;
    self.SetContentFrameBlock = ^void(UIView *contentView){
        CGFloat contentX = 0;
        CGFloat contentY = 100;
        CGFloat contentW = weakSelf.view.bounds.size.width;
        CGFloat contentH = weakSelf.view.bounds.size.height- contentY;
        contentView.frame = CGRectMake(contentX, contentY, contentW, contentH);
    };
    // 是否显示底部指示器
    self.displayUnderlineView = true;
}

// 添加所有子控制器
- (void)setUpAllViewController
{
    // 段子
    ChildViewController *wordVc1 = [[ChildViewController alloc] init];
    wordVc1.title = @"社会";
    [self addChildViewController:wordVc1];
    
    // 段子
    ChildViewController *wordVc2 = [[ChildViewController alloc] init];
    wordVc2.title = @"体育";
    [self addChildViewController:wordVc2];
    
    // 视频
    ChildViewController *videoVc = [[ChildViewController alloc] init];
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    
    // 声音
    ChildViewController *voiceVc = [[ChildViewController alloc] init];
    voiceVc.title = @"电台";
    [self addChildViewController:voiceVc];
    
    ChildViewController *wordVc4 = [[ChildViewController alloc] init];
    wordVc4.title = @"热点新闻";
    [self addChildViewController:wordVc4];
    
    // 图片
    ChildViewController *pictureVc = [[ChildViewController alloc] init];
    pictureVc.title = @"图片";
    [self addChildViewController:pictureVc];
    
    // 段子
    ChildViewController *wordVc = [[ChildViewController alloc] init];
    wordVc.title = @"段子";
    [self addChildViewController:wordVc];
    
    // 段子
    ChildViewController *wordVc3 = [[ChildViewController alloc] init];
    wordVc3.title = @"NBA录像";
    [self addChildViewController:wordVc3];
    
    ChildViewController *wordVc5 = [[ChildViewController alloc] init];
    wordVc5.title = @"热门";
    [self addChildViewController:wordVc5];
}

@end
