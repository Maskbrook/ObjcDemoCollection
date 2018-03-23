//
//  InfiniteBannerView.m
//  InfiniteBannerView
//
//  Created by jiabaozhang on 17/4/20.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "InfiniteBannerView.h"
#import "InfiniteBannerViewCell.h"
#import "InfiniteBannerViewItem.h"

static NSString * const reuseIdentifier = @"reuseIdentifier";

@interface InfiniteBannerView ()<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) NSTimer *timer;


@end

@implementation InfiniteBannerView
@synthesize imageUrls = _imageUrls;

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = self.bounds.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor lightGrayColor];
    [collectionView registerClass:[InfiniteBannerViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.pagingEnabled = true;
    collectionView.showsHorizontalScrollIndicator = false;
    [self addSubview:collectionView];
    _collectionView = collectionView;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.userInteractionEnabled = false;
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    // 可以通过KVC设置pageControl指示器样式
//    [pageControl setValue:[UIImage imageNamed:@""] forKeyPath:@"_pageImage"];
//    [pageControl setValue:[UIImage imageNamed:@""] forKeyPath:@"_currentPageImage"];
    [self addSubview:pageControl];
    _pageControl = pageControl;
}

- (void)layoutSubviews
{
    if (_imageUrls.count) {
        // [item4, item1, item2, item3, item4, item1]
        // 索引为0的其实是最后一个item，因此移动到索引为1的item
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:false];
    }
    _collectionView.frame = self.bounds;
    _pageControl.frame = CGRectMake(0, self.bounds.size.height-20, self.bounds.size.width, 20);
    [super layoutSubviews];
}

#pragma mark - setter & getter
- (NSArray *)imageUrls
{
    if (_imageUrls == nil) {
        _imageUrls = [NSArray array];
    }
    return _imageUrls;
}

- (void)setImageUrls:(NSArray *)imageUrls
{
    _imageUrls = imageUrls;
    
    if ([imageUrls count]) {
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObject:[imageUrls lastObject]];
        [arr addObjectsFromArray:imageUrls];
        [arr addObject:[imageUrls firstObject]];
        _imageUrls = [NSArray arrayWithArray:arr];
    }
    
    if (imageUrls.count <= 1) {
        _pageControl.hidden = true;
        return;
    }
    _pageControl.numberOfPages = _imageUrls.count - 2;
}

- (void)setScrollingInterval:(NSInteger)scrollingInterval
{
    _scrollingInterval = scrollingInterval;
    [self startTimer];
}


#pragma mark - collectionView datasource & delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return MAX(self.imageUrls.count, 1);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    InfiniteBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    InfiniteBannerViewItem *item = self.imageUrls[indexPath.item];
    cell.item = item;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    InfiniteBannerViewItem *item = self.imageUrls[indexPath.item];
    item.handler ? item.handler(item) : NULL;
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self calculateCollectionScrollPosition];
    [self calculateCurrentPage];
}

// 开始拖拽的时候停止计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

// 结束拖拽的时候开始定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

#pragma mark - Private Method
- (void)calculateCollectionScrollPosition
{
    CGFloat scrollWidth = CGRectGetWidth(self.bounds);
    
    // 向左滑动时切换item
    if (self.collectionView.contentOffset.x <= 0)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[self.imageUrls count] - 2 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
    }
    // 向右滑动时切换item
    if (self.collectionView.contentOffset.x >= ([self.imageUrls count] - 1) * scrollWidth)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
    }
}

- (void)calculateCurrentPage
{
    // 以中线作为判断点，过了中线才算是到了下一页。
    CGPoint adjustPoint = CGPointMake(self.collectionView.contentOffset.x + (0.5 * CGRectGetWidth(self.collectionView.frame)), self.collectionView.contentOffset.y);
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:adjustPoint];
    
    NSInteger page;
    NSInteger index = indexPath.item;
    NSInteger suffixIndex = self.imageUrls.count - 1;
    NSInteger prefixIndex = 0;
    
    NSInteger firstPage = 0;
    NSInteger lastPage = suffixIndex - 2;
    
    if (index == prefixIndex) {
        page = lastPage;
    } else if (index == suffixIndex) {
        page = firstPage;
    } else {
        page = index - 1;
    }
    
    _pageControl.currentPage = page;
}

- (void)scrollToNextPage
{
    if (self.imageUrls.count > 1)
    {
        NSIndexPath *currentIndexPath = [self.collectionView indexPathForItemAtPoint:self.collectionView.contentOffset];
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:currentIndexPath.item + 1
                                                         inSection:currentIndexPath.section];
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:true];
    }
}

- (void)startTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:_scrollingInterval target:self selector:@selector(scrollToNextPage) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}


@end

