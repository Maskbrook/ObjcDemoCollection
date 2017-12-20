//
//  BaseTableViewController.h
//  OCProjects
//
//  Created by jiabaozhang on 2017/12/7.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : UITableViewController

/**
 tableView的数据源
 */
@property (nonatomic, strong) NSMutableArray *items;

/**
 根据传入的NSINdexPath跳转控制器
 @param path tableViewCell的indexPath
 */
- (void)pushViewControllerWithIndexPath:(NSIndexPath *)path;

@end
