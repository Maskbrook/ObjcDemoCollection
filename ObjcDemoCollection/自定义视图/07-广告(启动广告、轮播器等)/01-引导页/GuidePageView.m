//
//  GuidePageView.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/3/26.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "GuidePageView.h"

@interface GuidePageView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *enterButton;
@property (nonatomic, strong) NSArray *images;

@end

@implementation GuidePageView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)imageNames
{
    if (self = [super initWithFrame:frame]) {
        _images = imageNames;
        [self commitUI];
    }
    return self;
}

#pragma mark - UI
- (void)commitUI
{
    //scrollView
    [self getScrollView];
    
    //page control
    [self getPageControl];
    
    //images
    [self getImagesView];
}

- (void)getScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsHorizontalScrollIndicator = false;
    self.scrollView.showsVerticalScrollIndicator = false;
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width * self.images.count, self.bounds.size.height);
    self.scrollView.bounces = false;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
}

- (void)getPageControl
{
    CGFloat pageControlW = 300;
    CGFloat pageControlH = 40;
    CGFloat pageControlX = (self.bounds.size.width - pageControlW) / 2;
    CGFloat pageControlY = (self.bounds.size.height - pageControlH - 20);
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH)];
    self.pageControl.backgroundColor = [UIColor clearColor];
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = self.images.count;
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor magentaColor];
    [self addSubview:self.pageControl];
}

- (void)getImagesView
{
    CGFloat imgX = 0;
    CGFloat imgY = 0;
    CGFloat imgW = self.bounds.size.width;
    CGFloat imgH = self.bounds.size.height;
    for (int i = 0; i < self.images.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.scrollView addSubview:imgView];
        imgX = i * imgW;
        imgView.image = [UIImage imageNamed:self.images[i]];
        imgView.frame = CGRectMake(imgX, imgY, imgW, imgH);
        
        //enter button
        CGFloat btnW = 150;
        CGFloat btnH = 44;
        CGFloat btnX = (self.bounds.size.width - btnW) / 2;
        CGFloat btnY = (self.bounds.size.height - btnH - 100);
        if (i == self.images.count - 1) {
            imgView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideGuidePageView)];
            tap.numberOfTapsRequired = 1;
            [imgView addGestureRecognizer:tap];
            
            self.enterButton = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
            self.enterButton.layer.cornerRadius = 5;
            self.enterButton.clipsToBounds = YES;
            [self.enterButton setTitle:@"立即探索" forState:UIControlStateNormal];
            self.enterButton.backgroundColor = kThemeColor;
            [imgView addSubview:_enterButton];
            WS(weakSelf);
            self.enterButton.actionBlock = ^{
                [weakSelf hideGuidePageView];
            };
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 向下取整
    NSInteger currentPage = scrollView.contentOffset.x/scrollView.bounds.size.width + 0.5;
    if (self.pageControl.currentPage != currentPage) {
        self.pageControl.currentPage = currentPage;
    }
}

#pragma mark - public
- (void)hideGuidePageView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
    }];
}

@end
