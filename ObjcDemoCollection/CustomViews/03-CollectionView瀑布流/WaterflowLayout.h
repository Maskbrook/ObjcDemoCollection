//
//  WaterflowLayout.h
//  ObjectiveCSummmaryDemo
//
//  Created by jiabaozhang on 2017/5/6.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaterflowLayout;

@protocol WaterflowLayoutDelegate <NSObject>
@required
// 根据传入的width按照比例计算height
- (CGFloat)waterflowLayout:(WaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;
@optional
// 列数
- (int)columnCountOfWaterflowLayout:(WaterflowLayout *)waterflowLayout;
// 列间距
- (CGFloat)columnMarginOfWaterflowLayout:(WaterflowLayout *)waterflowLayout;
// 行间距
- (CGFloat)rowMarginOfWaterflowLayout:(WaterflowLayout *)waterflowLayout;
// 内边距
- (UIEdgeInsets)edgeInsetsOfWaterflowLayout:(WaterflowLayout *)waterflowLayout;
@end

@interface WaterflowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<WaterflowLayoutDelegate> delegate;

@end
