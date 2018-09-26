//
//  PopMenuViewCell.m
//  CustomPopMenuView
//
//  Created by jiabaozhang on 17/4/10.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "PopMenuViewCell.h"
#import "PopMenuItem.h"

@interface PopMenuViewCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation PopMenuViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.imgView = [[UIImageView alloc] init];
    [self addSubview:self.imgView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self addSubview:self.titleLabel];
    
    self.bottomLine = [[UIView alloc] init];
    self.bottomLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.bottomLine];
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat imgViewWidthHeight = 25.0;
    CGFloat imgViewX = 15.0;
    CGFloat imgViewY = (CGRectGetHeight(self.bounds) - imgViewWidthHeight) / 2;
    CGFloat padding = 10.0;
    self.imgView.frame = CGRectMake(imgViewX, imgViewY, imgViewWidthHeight, imgViewWidthHeight);
    self.titleLabel.frame = CGRectMake(
                                       CGRectGetMaxX(self.imgView.frame) + padding,
                                       CGRectGetMinY(self.imgView.frame),
                                       (CGRectGetWidth(self.bounds) - CGRectGetMaxX(self.imgView.frame) - padding * 2),
                                       CGRectGetHeight(self.imgView.frame));
    self.bottomLine.frame = CGRectMake(0,
                                       CGRectGetMaxY(self.bounds) - 0.5,
                                       CGRectGetWidth(self.bounds),
                                       0.5);
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
}

- (void)updatePopMenuItem:(PopMenuItem *)item
{
    self.imgView.image = item.image;
    self.titleLabel.text = item.title;
}

- (void)bottomLineShouldHide:(BOOL)shouldHide
{
    self.bottomLine.hidden = shouldHide;
}

@end
