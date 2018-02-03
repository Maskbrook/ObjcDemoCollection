//
//  ShopTableViewCell.h
//  PPMVVMTableDemo
//
//  Created by jiabaozhang on 17/5/4.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopData;

@interface ShopTableViewCell : UITableViewCell

@property (nonatomic, strong) ShopData *data;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
