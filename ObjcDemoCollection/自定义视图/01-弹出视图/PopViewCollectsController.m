//
//  PopViewCollectsController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/3/26.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "PopViewCollectsController.h"
#import "BaseTableViewCell.h"
#import "PopMenuController.h"
#import "DatePickerViewController.h"

@interface PopViewCollectsController ()

@end

@implementation PopViewCollectsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.items = @[
                   @{@"title" : @"01-带箭头的弹出菜单", @"controller" : [PopMenuController new]},
                   @{@"title" : @"02-日期选择", @"controller" : [DatePickerViewController new]},
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
