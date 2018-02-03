//
//  InfiniteBannerViewCell.m
//  InfiniteBannerView
//
//  Created by jiabaozhang on 17/4/20.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "InfiniteBannerViewCell.h"
#import "InfiniteBannerViewItem.h"
#import "UIImageView+WebCache.h"

@interface InfiniteBannerViewCell ()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *textLabel;

@end

@implementation InfiniteBannerViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        _imageView = imageView;
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
        textLabel.font = [UIFont systemFontOfSize:13.0];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];
        _textLabel = textLabel;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    _textLabel.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-50, CGRectGetWidth(self.bounds), 50);
}

- (void)setItem:(InfiniteBannerViewItem *)item
{
    _item = item;
    [_imageView sd_setImageWithURL:item.imageUrl placeholderImage:[UIImage imageNamed:@"home_banner_jiazai"]];
    _textLabel.text = item.title;
}

@end
