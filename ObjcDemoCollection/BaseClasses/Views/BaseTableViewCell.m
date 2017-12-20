//
//  BaseTableViewCell.m
//  OCProjects
//
//  Created by jiabaozhang on 2017/12/7.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "BaseTableViewCell.h"
#import <Masonry.h>

@implementation BaseTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)aTableView
{
    static NSString *reuseIdentifier = @"BaseTableViewCell";
    BaseTableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = kTableViewCellBgColor;
        [self layoutCellSubviews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma mark ## private methods ##
- (void)layoutCellSubviews
{
    WS(weakSelf);
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(weakSelf.contentView.mas_height);
        make.left.mas_equalTo(weakSelf.mas_left).offset(15);
    }];
}

#pragma mark ## getter && setter ##
- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = FONT(15);
        _nameLabel.numberOfLines = 0;
        _nameLabel.textColor = kThemeColor;
    }
    return _nameLabel;
}

@end
