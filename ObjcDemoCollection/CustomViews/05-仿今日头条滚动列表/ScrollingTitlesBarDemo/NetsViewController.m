//
//  NetsViewController.m
//  PPScrollingTagsDemo
//
//  Created by jiabaozhang on 17/5/17.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "NetsViewController.h"
#import "ChildViewController.h"

@interface NetsViewController ()

@end

@implementation NetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化子控件
    [self setUpAllViewController];
    // 设置frame
    __typeof(self) weakSelf = self;
    self.SetContentFrameBlock = ^void(UIView *contentView){
        CGFloat contentX = 0;
        CGFloat contentY = 64;
        CGFloat contentW = weakSelf.view.bounds.size.width;
        CGFloat contentH = weakSelf.view.bounds.size.height- contentY;
        contentView.frame = CGRectMake(contentX, contentY, contentW, contentH);
    };
    self.displayCoverView = true;
    self.displayUnderlineView = true;
}

// 添加所有子控制器
- (void)setUpAllViewController
{
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
}


@end
