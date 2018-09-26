//
//  ScrollingBarParentController.m
//  ObjectiveCSummmaryDemo
//
//  Created by jiabaozhang on 17/5/17.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "ScrollingBarParentController.h"
#import "ScrollingBarItem.h"
#import "ScrollingBarCollectionLayout.h"
#import "UIView+Frame.h"

#pragma mark - static const
// colletionView reuse id
static NSString * const ID = @"reuseIdentifier";
// 导航条 + status 高度
static CGFloat const NavBarHeight = 64.0;
// 标题滚动视图的高度
static CGFloat const TitleScrollViewHeight = 44.0;
// 默认标题间距
static CGFloat const margin = 20.0;

#define ScreenWidth self.contentView.bounds.size.width
#define ScreenHeight self.contentView.bounds.size.height
#define DefaultTitleFont [UIFont systemFontOfSize:14]

@interface ScrollingBarParentController ()<UICollectionViewDataSource, UICollectionViewDelegate>

#pragma mark - UI View
// 总体view（包含标题和内容）
@property (nonatomic, weak) UIView *contentView;
// 标题view
@property (nonatomic, weak) UIScrollView *titleScrollView;
// 内容view
@property (nonatomic, weak) UICollectionView *contentScrollView;
// 下划线view
@property (nonatomic, weak) UIView *underlineView;
// 遮盖view
@property (nonatomic, weak) UIView *coverView;
#pragma mark - data
// 所有标题数组
@property (nonatomic, strong) NSMutableArray *titleLabels;
// 所有标题宽度数组
@property (nonatomic, strong) NSMutableArray *titleWidths;
// 上一次选中的角标
@property (nonatomic, assign) NSInteger lastSelectedIndex;
// 记录上一次内容滚动视图偏移量
@property (nonatomic, assign) CGFloat lastOffsetX;
// 选中的索引
@property (nonatomic, assign) NSInteger selectedIndex;
// 下划线高度
@property (nonatomic, assign) CGFloat underlineHeight;
// 计算出的标题间距
@property (nonatomic, assign) CGFloat titleMargin;
#pragma mark - color
// 标题未选中颜色
@property (nonatomic, strong) UIColor *normalColor;
// 标题选中颜色
@property (nonatomic, strong) UIColor *selectColor;
// 下划线颜色
@property (nonatomic, strong) UIColor *underlineColor;
#pragma mark - bool
// 是否正在执行滚动
@property (nonatomic, assign) BOOL isAnimating;
// 是否点击了标题
@property (nonatomic, assign) BOOL isSelectingLabel;

@end

@implementation ScrollingBarParentController

#pragma mark - 生命周期
// view已经调整Subviews的位置，在调整完成之后要做的一些工作就可以在该方法中实现。
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat statusH = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat titleY = self.navigationController.navigationBarHidden == NO?NavBarHeight:statusH;
    
    if (self.contentView.frame.size.height == 0) {
        self.contentView.frame = CGRectMake(0, titleY, ScreenWidth, ScreenHeight - titleY);
    }
    
    // 顶部标题View尺寸
    self.titleScrollView.frame = CGRectMake(0, 0, ScreenWidth, TitleScrollViewHeight);
    
    // 顶部内容View尺寸
    CGFloat contentY = CGRectGetMaxY(self.titleScrollView.frame);
    CGFloat contentH = self.contentView.pp_height - contentY;
    self.contentScrollView.frame = CGRectMake(0, contentY, ScreenWidth, contentH);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self calculateLabelWidths];
    [self setUpAllTitles];
}

#pragma mark - 初始化
- (instancetype)init
{
    if (self = [super init]) {
        [self commit];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self commit];
}

- (void)commit
{
    // 是否自动调整scrollview的inset
    self.automaticallyAdjustsScrollViewInsets = false;
    // 初始化
    self.scale = 0.1;
    self.displayCoverView = false;
    self.displayUnderlineView = false;
    self.underlineHeight = 2.0;
    self.underlineColor = [UIColor redColor];
}

#pragma mark - setter
- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
}

- (void)setSetContentFrameBlock:(void (^)(UIView *))SetContentFrameBlock
{
    _SetContentFrameBlock = SetContentFrameBlock;
    if (SetContentFrameBlock) {
        SetContentFrameBlock(self.contentView);
    }
}

- (void)setScale:(CGFloat)scale
{
    _scale = scale;
}

- (void)setDisplayCoverView:(BOOL)displayCoverView
{
    _displayCoverView = displayCoverView;
}

- (void)setDisplayUnderlineView:(BOOL)displayUnderlineView
{
    _displayUnderlineView = displayUnderlineView;
}

#pragma mark - setUp UI

/**
 *  计算所有标题的宽度
 */
- (void)calculateLabelWidths
{
    NSUInteger count = self.childViewControllers.count;
    NSArray *titles = [self.childViewControllers valueForKeyPath:@"title"];
    CGFloat totalWidth = 0;
    
    for (NSString *title in titles) {
        if ([title isKindOfClass:[NSNull class]]) {
            // 抛异常
            NSException *excp = [NSException exceptionWithName:@"ScrollingTitleViewControllerException" reason:@"没有设置Controller.title属性，应该把子标题保存到对应子控制器中" userInfo:nil];
            [excp raise];
        }
        
        CGRect titleBounds = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:DefaultTitleFont} context:nil];
        CGFloat width = titleBounds.size.width;
        [self.titleWidths addObject:@(width)];
        totalWidth += width;
    }
    
    // 根据所有标题宽度之和 计算布局时title之间的实际间距
    // 总宽度 > ScreenWidth: margin仍然是默认值20
    // 总宽度 <= ScreenWidth: margin需要重新计算，才能使label铺满
    if (totalWidth > ScreenWidth) {
        _titleMargin = margin;
        return;
    }
    CGFloat titleMargin = (ScreenWidth - totalWidth) / (count + 1);
    _titleMargin = titleMargin < margin? margin: titleMargin;
}

/**
 *  添加所有标题
 */
- (void)setUpAllTitles
{
    NSUInteger count = self.childViewControllers.count;
    CGFloat labelW = 0;
    CGFloat labelH = TitleScrollViewHeight;
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    for (int i = 0; i < count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        UILabel *label = [[ScrollingBarItem alloc] init];
        label.tag = i;
        label.textColor = self.normalColor;
        label.font = DefaultTitleFont;
        label.text = vc.title;
        
        labelW = [self.titleWidths[i] floatValue];
        UILabel *lastLabel = [self.titleLabels lastObject];
        labelX = _titleMargin + CGRectGetMaxX(lastLabel.frame);
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        // 监听标题的点击
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClickAction:)];
        [label addGestureRecognizer:tap];
        
        // 保存到数组
        [self.titleLabels addObject:label];
        [_titleScrollView addSubview:label];
        
        if (i == _selectedIndex) { // 默认选中第0个index
            [self labelClickAction:tap];
        }
    }
    
    // 设置标题滚动视图的内容范围
    UILabel *lastLabel = self.titleLabels.lastObject;
    _titleScrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame), 0);
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.contentSize = CGSizeMake(count * ScreenWidth, 0);
}

#pragma mark - 点击label须调用的系列方法
/**
 *  label点击action
 */
- (void)labelClickAction:(UITapGestureRecognizer *)tap
{
    // 记录是否点击了label
    self.isSelectingLabel = true;
    // 取出点击的label
    UILabel *selectedLabel = (UILabel *)tap.view;
    NSInteger selectedIndex = selectedLabel.tag;
    
    // 选中label
    [self selectLabel:selectedLabel];
    
    // 设置内容视图的位置
    CGFloat offsetX = selectedIndex * ScreenWidth;
    self.contentScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 记录上一次偏移量
    // 点击的时候不会调用scrollView代理记录，因此需要主动记录
    self.lastOffsetX = offsetX;
    
    // 更新选中的index
    self.selectedIndex = selectedIndex;
    
    // 点击label事件完成
    self.isSelectingLabel = false;
    
    [self scrollViewDidEndDecelerating:self.contentScrollView];
}

/**
 *  label选中action
 */
- (void)selectLabel:(UILabel *)selectLabel
{
    for (ScrollingBarItem *label in self.titleLabels) {
        if (label == selectLabel) continue;
        label.transform = CGAffineTransformIdentity;
        label.textColor = self.normalColor;
    }
    
    // 缩放
    CGFloat scaleTransform = self.scale + 1.0;
    selectLabel.transform = CGAffineTransformMakeScale(scaleTransform, scaleTransform);
    
    // 选中颜色
    selectLabel.textColor = self.selectColor;
    
    // 滚动选中label
    [self labelClickActionSelectedlabelLocation:selectLabel];
    
    // 滚动下划线指示器到选中label
    if (self.displayUnderlineView) {
        [self labelClickActionUnderlineLocation:selectLabel];
    }
    
    // 滚动遮盖view到选中label
    if (self.displayCoverView) {
        [self labelClickActionCoverLocation:selectLabel];
    }
    
}

/**
 *  滚动coverView到选中label
 */
- (void)labelClickActionCoverLocation:(UILabel *)selectedlabel
{
    // 获取文字尺寸
    CGRect titleBounds = [selectedlabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:DefaultTitleFont} context:nil];
    
    CGFloat borderX = 10;
    CGFloat borderY = 5;
    CGFloat coverH = titleBounds.size.height + borderY * 2;
    CGFloat coverW = titleBounds.size.width + borderX * 2;
    
    self.coverView.pp_y = (TitleScrollViewHeight - coverH) * 0.5;
    self.coverView.pp_height = coverH;
    self.coverView.pp_width = coverW;
    
    // 最开始不需要动画
    if (self.coverView.pp_x == 0) {
        self.coverView.pp_width = coverW;
        self.coverView.pp_centerX = selectedlabel.pp_centerX;
        return;
    }
    
    // 点击时候需要动画
    [UIView animateWithDuration:0.25 animations:^{
        self.coverView.pp_width = coverW;
        self.coverView.pp_centerX = selectedlabel.pp_centerX;
    }];
    
}


/**
 *  滚动下划线到选中label下方
 */
- (void)labelClickActionUnderlineLocation:(UILabel *)selectedlabel
{
    self.underlineView.pp_y = TitleScrollViewHeight - self.underlineHeight;
    self.underlineView.pp_height = self.underlineHeight;
    
    // 最开始不需要动画
    if (self.underlineView.pp_x == 0) {
        self.underlineView.pp_width = selectedlabel.pp_width;
        self.underlineView.pp_centerX = selectedlabel.pp_centerX;
        return;
    }
    
    // 点击时候需要动画
    [UIView animateWithDuration:0.25 animations:^{
        self.underlineView.pp_width = selectedlabel.pp_width;
        self.underlineView.pp_centerX = selectedlabel.pp_centerX;
    }];
}

/**
 *  滚动选中label到合适位置
 */
- (void)labelClickActionSelectedlabelLocation:(UILabel *)selectedlabel
{
    // 设置标题滚动区域的偏移量
    CGFloat offsetX = selectedlabel.center.x - ScreenWidth * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }
    // 计算下最大的标题视图滚动区域
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - ScreenWidth + self.titleMargin;
    if (maxOffsetX < 0) {
        maxOffsetX = 0;
    }
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    // 滚动区域
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}


#pragma mark - collectionView datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    // 移除之前的子控件
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 添加控制器
    UIViewController *vc = self.childViewControllers[indexPath.row];
    vc.view.frame = CGRectMake(0, 0, self.contentScrollView.pp_width, self.contentScrollView.pp_height);
    
    CGFloat bottom = (self.tabBarController == nil ? 0 : 49);
    CGFloat top = 0;
    if ([vc isKindOfClass:[UITableViewController class]]) {
        UITableViewController *tableViewVc = (UITableViewController *)vc;
        tableViewVc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    }
    [cell.contentView addSubview:vc.view];
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
/**
 *  正在滚动
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.isAnimating || self.titleLabels.count == 0) {
        return;
    }
    
    CGFloat offsetX = scrollView.contentOffset.x;
    // 获取左边角标
    NSInteger leftIndex = offsetX / ScreenWidth;
    
    // 左边label
    ScrollingBarItem *leftLabel = self.titleLabels[leftIndex];
    
    // 右边角标
    NSInteger rightIndex = leftIndex + 1;
    
    // 右边label
    ScrollingBarItem *rightLabel = nil;
    
    if (rightIndex < self.titleLabels.count) {
        rightLabel = self.titleLabels[rightIndex];
    }
    
    // 缩放
    [self setUpTitleScaleWithOffset:offsetX rightLabel:rightLabel leftLabel:leftLabel];
    
    // 下划线
    [self setUpUnderLineOffset:offsetX rightLabel:rightLabel leftLabel:leftLabel];
    
    // 设置遮盖偏移
    [self setUpCoverOffset:offsetX rightLabel:rightLabel leftLabel:leftLabel];
    
    // 记录上一次的偏移量
    _lastOffsetX = offsetX;
}


/**
 *  滚动完毕就会调用
 *  人为拖拽scrollView导致滚动完毕，才会调用这个方法
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger offsetXInt = offsetX;
    NSInteger screenWInt = ScreenWidth;
    
    NSInteger extre = offsetXInt % screenWInt;
    if (extre > ScreenWidth * 0.5) {
        // 往右边移动
        offsetX = offsetX + (ScreenWidth - extre);
        _isAnimating = YES;
        [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }else if (extre < ScreenWidth * 0.5 && extre > 0){
        _isAnimating = YES;
        // 往左边移动
        offsetX =  offsetX - extre;
        [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    
    // 获取角标
    NSInteger i = offsetX / ScreenWidth;
    
    // 选中标题
    [self selectLabel:self.titleLabels[i]];
    
    // 取出对应控制器发出通知
    UIViewController *vc = self.childViewControllers[i];
    
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ScrollingTitleViewClickOrScrollDidFinshNote" object:vc];
}

/**
 *  滚动完毕就会调用
 *  非人为拖拽scrollView导致滚动完毕，才会调用这个方法
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    _isAnimating = false;
}

#pragma mark - 滑动contentScrollView须调用的方法
/**
 *  设置遮盖偏移
 */
- (void)setUpCoverOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel
{
    if (_isSelectingLabel) return;
    
    // 获取两个标题中心点距离
    CGFloat centerDelta = rightLabel.pp_x - leftLabel.pp_x;
    
    // 标题宽度差值
    CGFloat widthDelta = [self widthDeltaWithRightLabel:rightLabel leftLabel:leftLabel];
    
    // 获取移动距离
    CGFloat offsetDelta = offsetX - _lastOffsetX;
    
    // 计算当前下划线偏移量
    CGFloat coverTransformX = offsetDelta * centerDelta / ScreenWidth;
    
    // 宽度递增偏移量
    CGFloat coverWidth = offsetDelta * widthDelta / ScreenWidth;
    
    self.coverView.pp_width += coverWidth;
    self.coverView.pp_x += coverTransformX;
    
}

/**
 *  设置标题缩放
 */
- (void)setUpTitleScaleWithOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel
{
    // 获取右边缩放
    CGFloat rightSacle = offsetX / ScreenWidth - leftLabel.tag;
    
    CGFloat leftScale = 1 - rightSacle;
    
    CGFloat scaleTransform = self.scale + 1.0;
    scaleTransform -= 1;
    
    // 缩放label
    leftLabel.transform = CGAffineTransformMakeScale(leftScale * scaleTransform + 1, leftScale * scaleTransform + 1);
    rightLabel.transform = CGAffineTransformMakeScale(rightSacle * scaleTransform + 1, rightSacle * scaleTransform + 1);
}

/**
 *  设置下划线偏移
 */
- (void)setUpUnderLineOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel
{
    if (_isSelectingLabel) return;
    
    // 获取两个标题中心点距离
    CGFloat centerDelta = rightLabel.pp_x - leftLabel.pp_x;
    
    // 标题宽度差值
    CGFloat widthDelta = [self widthDeltaWithRightLabel:rightLabel leftLabel:leftLabel];
    
    // 获取移动距离
    CGFloat offsetDelta = offsetX - self.lastOffsetX;
    
    // 计算当前下划线偏移量
    CGFloat underLineTransformX = offsetDelta * centerDelta / ScreenWidth;
    
    // 宽度递增偏移量
    CGFloat underLineWidth = offsetDelta * widthDelta / ScreenWidth;
    
    self.underlineView.pp_width += underLineWidth;
    self.underlineView.pp_x += underLineTransformX;
}

/**
 *  获取两个label宽度差值
 */
- (CGFloat)widthDeltaWithRightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel
{
    CGRect titleBoundsR = [rightLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:DefaultTitleFont} context:nil];
    
    CGRect titleBoundsL = [leftLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:DefaultTitleFont} context:nil];
    
    return titleBoundsR.size.width - titleBoundsL.size.width;
}

#pragma mark - 懒加载
// 懒加载标题滚动视图
- (UIScrollView *)titleScrollView
{
    if (_titleScrollView == nil) {
        UIScrollView *titleScrollView = [[UIScrollView alloc] init];
        titleScrollView.scrollsToTop = NO;
        titleScrollView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:titleScrollView];
        _titleScrollView = titleScrollView;
    }
    return _titleScrollView;
}

// 懒加载内容滚动视图
- (UICollectionView *)contentScrollView
{
    if (_contentScrollView == nil) {
        ScrollingBarCollectionLayout *layout = [[ScrollingBarCollectionLayout alloc] init];
        UICollectionView *contentScrollView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _contentScrollView = contentScrollView;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.bounces = NO;
        _contentScrollView.delegate = self;
        _contentScrollView.dataSource = self;
        _contentScrollView.scrollsToTop = NO;
        [_contentScrollView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
        _contentScrollView.backgroundColor = self.view.backgroundColor;
        [self.contentView insertSubview:contentScrollView belowSubview:self.titleScrollView];
    }
    return _contentScrollView;
}

// 懒加载整个内容view
- (UIView *)contentView
{
    if (_contentView == nil) {
        UIView *contentView = [[UIView alloc] init];
        _contentView = contentView;
        [self.view addSubview:contentView];
    }
    return _contentView;
}

- (UIView *)coverView
{
    if (_coverView == nil) {
        UIView *coverView = [[UIView alloc] init];
        coverView.backgroundColor = [UIColor darkGrayColor];
        coverView.layer.cornerRadius = 13.0;
        [self.titleScrollView insertSubview:coverView atIndex:0];
        _coverView = coverView;
    }
    return _coverView;
}

- (UIView *)underlineView
{
    if (_underlineView == nil) {
        UIView *underLineView = [[UIView alloc] init];
        underLineView.backgroundColor = self.underlineColor;
        [self.titleScrollView addSubview:underLineView];
        _underlineView = underLineView;
    }
    return _underlineView;
}


- (NSMutableArray *)titleLabels
{
    if (_titleLabels == nil) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

- (NSMutableArray *)titleWidths
{
    if (_titleWidths == nil) {
        _titleWidths = [NSMutableArray array];
    }
    return _titleWidths;
}

- (UIColor *)normalColor
{
    if (_normalColor == nil) {
        _normalColor = [UIColor blackColor];
    }
    return _normalColor;
}

- (UIColor *)selectColor
{
    if (_selectColor == nil) {
        _selectColor = [UIColor redColor];
    }
    return _selectColor;
}

@end
