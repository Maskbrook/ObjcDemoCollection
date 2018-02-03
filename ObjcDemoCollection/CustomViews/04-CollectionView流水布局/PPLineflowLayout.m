//
//  PPLineflowLayout.m
//  PPCollectionViewLayoutDemo
//
//  Created by jiabaozhang on 17/4/25.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "PPLineflowLayout.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define ITEM_WIDTH (SCREEN_WIDTH * 0.5)
#define ITEM_HEIGHT (SCREEN_HEIGHT * 0.5)

#define ACTIVE_DISTANCE 200
#define ZOOM_FACTOR 0.3


@implementation PPLineflowLayout

/**
 *  初始化
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    CGFloat margin = (SCREEN_WIDTH - ITEM_WIDTH) * 0.5;
    self.itemSize = CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake(0, ABS(margin), 0, ABS(margin));
    self.minimumLineSpacing = 70;
}

/**
 *  刷新布局
 *  当collectionView的显示范围发生改变的时候，是否需要重新刷新布局
 *  一旦重新刷新布局，就会重新调用 layoutAttributesForElementsInRect:方法
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 *  放大当前item
 *  返回的数组里面存放着rect范围内所有元素的布局属性
 *  这个方法的返回值决定了rect范围内所有元素的排布（frame）
 *  一个cell对应一个UICollectionViewLayoutAttributes对象
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 取出父类算出的布局属性
    NSArray *attrsArray = [[NSArray alloc]initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    
    CGRect visibleRect = CGRectZero;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    // 遍历array中所有的UICollectionViewLayoutAttributes
    for (UICollectionViewLayoutAttributes *attributes in attrsArray) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
            if (ABS(distance) < ACTIVE_DISTANCE) {
                CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
                CGFloat zoom = 1 + ZOOM_FACTOR * (1 - ABS(normalizedDistance));
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
                attributes.zIndex = 1;
            }
        }
    }
    return attrsArray;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray *array = [[NSArray alloc]initWithArray:[super layoutAttributesForElementsInRect:targetRect] copyItems:YES];
    CGFloat offsetAdjustment = MAXFLOAT;
    
    // 理论上应cell停下来的中心点
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    
    // 对当前屏幕中的UICollectionViewLayoutAttributes逐个与屏幕中心进行比较，找出最接近中心的一个
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}


@end
