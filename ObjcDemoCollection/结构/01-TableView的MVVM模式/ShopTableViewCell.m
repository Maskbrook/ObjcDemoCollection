//
//  ShopTableViewCell.m
//  PPMVVMTableDemo
//
//  Created by jiabaozhang on 17/5/4.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "ShopTableViewCell.h"
#import "ShopData.h"
#import "UIImageView+WebCache.h"

@interface ShopTableViewCell ()

@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *priceLabel;

@end

@implementation ShopTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    ShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    UIImageView *imgView = [[UIImageView alloc] init];
    [self addSubview:imgView];
    _imgView = imgView;
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.backgroundColor = [UIColor clearColor];
    priceLabel.textColor = [UIColor magentaColor];
    priceLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:priceLabel];
    _priceLabel = priceLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 15.0;
    CGFloat imgSize = CGRectGetHeight(self.bounds)-10.0;
    _imgView.frame = CGRectMake(margin, 5.0, imgSize, imgSize);
    _priceLabel.frame = CGRectMake(imgSize+margin, 0, CGRectGetWidth(self.bounds)-imgSize-margin * 2, imgSize);
}



- (void)setData:(ShopData *)data
{
    data = data;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:data.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    self.priceLabel.text = data.price;
}

@end
