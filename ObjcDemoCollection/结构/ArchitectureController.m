//
//  ArchitectureController.m
//  ObjcDemoCollection
//
//  Created by 张家宝 on 2018/2/4.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "ArchitectureController.h"
#import "BaseTableViewCell.h"
#import "TableViewMVVMController.h"
#import "CellConfigTableViewController.h"

@interface ArchitectureController ()

@end

@implementation ArchitectureController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.items = @[
                   @{@"title" : @"01-tableView的MVVM设计模式", @"controller" : [TableViewMVVMController new]},
                   @{@"title" : @"02-config配置cell数据", @"controller" : [CellConfigTableViewController new]},
                   
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
