//
//  UserInfoTableViewCell.h
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/4/19.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "UserInfoCellConfig.h"

@interface UserInfoTableViewCell : BaseTableViewCell

@property (nonatomic, weak) UITextField *textField;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)aIndexPath config:(UserInfoCellConfig *)config;

@end
