//
//  UserInfoTableViewCell.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/4/19.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "UserInfoTableViewCell.h"

@implementation UserInfoTableViewCell
{
    __weak UserInfoCellConfig *_config;
    NSIndexPath *_indexPath;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)aIndexPath config:(UserInfoCellConfig *)config
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _indexPath = aIndexPath;
        _config = config;
        [self layoutPageSubviews];
    }
    return self;
}

- (void)layoutPageSubviews
{
    NSString *titleString =_config.titleOfCell;
    NSString *holder = _config.placeholder;
    
    UILabel *title = [UILabel new];
    title.font = [UIFont systemFontOfSize:15];
    title.text = titleString;
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.top.mas_equalTo(self.mas_top).offset(16);
        make.width.mas_equalTo(titleString.length*16);
    }];
    
    UITextField *textField = [UITextField new];
    textField.placeholder = holder;
    textField.textAlignment = NSTextAlignmentRight;
    [textField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    textField.keyboardType = _config.keyboardType;
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(16);
        make.left.mas_equalTo(title.mas_right).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(17);
    }];
    
    if (_config.isPicker) {
        UIImageView *icon = [UIImageView new];
        icon.image = [UIImage imageNamed:@"popup_arrow_right"];
        [self addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(16);
            make.right.mas_equalTo(self.mas_right).offset(-15);
            make.height.mas_equalTo(20);
        }];
        
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(16);
            make.left.mas_equalTo(title.mas_right).offset(10);
            make.right.mas_equalTo(self.mas_right).offset(-35);
            make.height.mas_equalTo(17);
        }];
    }
    
    self.textField = textField;
}

@end
