//
//  BaseTableViewCell.h
//  OCProjects
//
//  Created by jiabaozhang on 2017/12/7.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;


/**
 创建Cell
 @param aTableView 待创建cell的tableView
 @return BaseTableViewCell
 */
+ (instancetype)cellWithTableView:(UITableView *)aTableView;

@end
