//
//  WaterflowController.m
//  ObjectiveCSummmaryDemo
//
//  Created by jiabaozhang on 2017/5/6.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "WaterflowController.h"
#import "WaterflowCollectionCell.h"
#import "WaterflowLayout.h"
#import "WaterflowShopData.h"

static NSString * const reuseIdentifier = @"waterflowIdentifier";

@interface WaterflowController ()<UICollectionViewDataSource, UICollectionViewDelegate, WaterflowLayoutDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<WaterflowShopData *> *shops;

@end

@implementation WaterflowController

- (NSArray *)shops
{
    if (_shops == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"shops.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *shopArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            WaterflowShopData *shop = [[WaterflowShopData alloc] initWithDict:dict];
            [shopArray addObject:shop];
        }
        _shops = shopArray;
    }
    return _shops;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupCollectionView];
}

- (void)setupCollectionView
{
    WaterflowLayout *waterflowLayout = [[WaterflowLayout alloc] init];
    waterflowLayout.delegate = self;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:waterflowLayout];
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView registerClass:[WaterflowCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterflowCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.shop = self.shops[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterflowShopData *shop = self.shops[indexPath.item];
    NSLog(@"%@", shop.price);
}

#pragma mark - <WaterLayoutDelegate>
- (CGFloat)waterflowLayout:(WaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
    WaterflowShopData *shop = self.shops[index];
    return itemWidth * shop.h / shop.w;
}

- (int)columnCountOfWaterflowLayout:(WaterflowLayout *)waterflowLayout
{
    return 3;
}

- (CGFloat)rowMarginOfWaterflowLayout:(WaterflowLayout *)waterflowLayout
{
    return 10.0;
}

- (CGFloat)columnMarginOfWaterflowLayout:(WaterflowLayout *)waterflowLayout
{
    return 10.0;
}

- (UIEdgeInsets)edgeInsetsOfWaterflowLayout:(WaterflowLayout *)waterflowLayout
{
    return UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
}


@end
