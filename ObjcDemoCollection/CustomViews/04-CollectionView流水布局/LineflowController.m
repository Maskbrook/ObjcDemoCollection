//
//  LineflowController.m
//  PPCollectionViewLayoutDemo
//
//  Created by jiabaozhang on 17/4/25.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "LineflowController.h"
#import "PPLineflowLayout.h"
#import "WaterflowCollectionCell.h"
#import "WaterflowShopData.h"

static NSString * const reuseIdentifier = @"lineflowLayoutDemo";

@interface LineflowController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<WaterflowShopData *> *shops;

@end

@implementation LineflowController

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
    PPLineflowLayout *lineflowLayout = [[PPLineflowLayout alloc] init];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:lineflowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[WaterflowCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
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


@end
