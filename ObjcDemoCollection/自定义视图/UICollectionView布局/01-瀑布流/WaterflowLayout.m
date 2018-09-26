//
//  WaterflowLayout.m
//  ObjectiveCSummmaryDemo
//
//  Created by jiabaozhang on 2017/5/6.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "WaterflowLayout.h"

// 默认值
static const int kDefaultColumnCount = 2;
static const CGFloat kDefaultRowMargin = 5.0;
static const CGFloat kDefaultColumnMargin = 5.0;
static const UIEdgeInsets kDefaultEdgesets = {5.0, 5.0, 5.0, 5.0};

@interface WaterflowLayout ()

// 存放所有cell的布局属性
@property (nonatomic, strong) NSMutableArray *attrsArray;
// 存放所有列的高度
@property (nonatomic, strong) NSMutableArray *columnsHeights;
// collectionView内容的高度
@property (nonatomic, assign) CGFloat contentHeight;

- (int)columnCount;
- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (UIEdgeInsets)edgeInsets;

@end

@implementation WaterflowLayout

#pragma mark - <getter>
- (int)columnCount
{
    if ([self.delegate respondsToSelector:@selector(columnCountOfWaterflowLayout:)]) {
        return [self.delegate columnCountOfWaterflowLayout:self];
    } else {
        return kDefaultColumnCount;
    }
}

- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginOfWaterflowLayout:)]) {
        return [self.delegate rowMarginOfWaterflowLayout:self];
    } else {
        return kDefaultRowMargin;
    }
}

- (CGFloat)columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginOfWaterflowLayout:)]) {
        return [self.delegate columnMarginOfWaterflowLayout:self];
    } else {
        return kDefaultColumnMargin;
    }
}

- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsOfWaterflowLayout:)]) {
        return [self.delegate edgeInsetsOfWaterflowLayout:self];
    } else {
        return kDefaultEdgesets;
    }
}

#pragma mark - <custom layout>
/**
 * 初始化
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    self.collectionView.showsVerticalScrollIndicator = false;
    
    // 清除之前的布局
    [self.attrsArray removeAllObjects];
    [self.columnsHeights removeAllObjects];
    
    // 初始化
    self.contentHeight = 0.0;
    
    self.columnsHeights = [NSMutableArray array];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnsHeights addObject:@(self.edgeInsets.top)];
    }
    
    self.attrsArray = [NSMutableArray array];
    NSInteger collectionViewItemsCount = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < collectionViewItemsCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

/**
 * 决定cell的排布
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

/**
 * 返回indexPath位置cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    
    // 1. 设置布局属性的frame
    CGFloat w = (collectionViewWidth - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    CGFloat h = [self.delegate waterflowLayout:self heightForItemAtIndex:indexPath.item itemWidth:w];
    
    // 找出最短的列，在后面追加cell
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnsHeights[0] floatValue];
    for (NSInteger i = 1; i < self.columnCount; i++) {
        CGFloat columnHeight = [self.columnsHeights[i] floatValue];
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    CGFloat x = self.edgeInsets.left + destColumn * (w + self.columnMargin);
    CGFloat y = minColumnHeight;
    // collectionView不为空，需要加上行间距
    if (y != self.edgeInsets.top) {
        y += self.rowMargin;
    }
    attrs.frame = CGRectMake(x, y, w, h);
    
    // 2. 更新最短列的高度
    // 更新后最短列可能已经不是最短的了
    self.columnsHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
    // 3. 更新collectionView内容的高度
    // 如果内容高度已经小于更新后的“最短列”高度，“最短列”高度就是新的内容高度
    CGFloat columnHeight = [self.columnsHeights[destColumn] doubleValue];
    if (self.contentHeight < columnHeight) {
        self.contentHeight = columnHeight;
    }
    
    return attrs;
}

/**
 *  返回CollectionView的contensize
 */
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(0, self.contentHeight + self.edgeInsets.bottom);
}

@end
