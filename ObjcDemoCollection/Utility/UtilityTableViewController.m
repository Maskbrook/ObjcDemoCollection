//
//  UtilityTableViewController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/20.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "UtilityTableViewController.h"
// UI
#import "BaseTableViewCell.h"
// Controller
#import "KVOTableViewController.h"
#import "CheckAppVersionController.h"
#import "DeviceInfoController.h"

@interface UtilityTableViewController ()

@end

@implementation UtilityTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.items = @[
                   @{@"title" : @"01-KVO的几种实现", @"controller" : [KVOTableViewController new]},
                   @{@"title" : @"02-检测app版本更新", @"controller" : [CheckAppVersionController new]},
                   @{@"title" : @"03-UUID等设备信息", @"controller" : [DeviceInfoController new]},
                   
                   ].mutableCopy;
}

#pragma mark ## tableView methods ##
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableViewCell *cell = [BaseTableViewCell cellWithTableView:tableView];
    cell.nameLabel.text = [[self.items objectAtIndex:indexPath.row] valueForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushViewControllerWithIndexPath:indexPath];
}

@end
