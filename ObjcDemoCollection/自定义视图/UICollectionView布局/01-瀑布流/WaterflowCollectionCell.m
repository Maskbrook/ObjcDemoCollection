//
//  WaterflowCollectionCell.m
//  ObjectiveCSummmaryDemo
//
//  Created by jiabaozhang on 2017/5/6.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "WaterflowCollectionCell.h"
#import "UIImageView+WebCache.h"
#import "WaterflowShopData.h"

@interface WaterflowCollectionCell ()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *priceLabel;

@end

@implementation WaterflowCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        _imageView = imageView;
        
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
        priceLabel.textColor = [UIColor whiteColor];
        [self addSubview:priceLabel];
        _priceLabel = priceLabel;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    _priceLabel.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-30, CGRectGetWidth(self.bounds), 30);
}

- (void)setShop:(WaterflowShopData *)shop
{
    _shop = shop;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    self.priceLabel.text = shop.price;
}

@end
