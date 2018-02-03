//
//  InsideObjCTableViewController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/28.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "InsideObjCTableViewController.h"
#import "BaseTableViewCell.h"
#import "IMPCallSelectorDemoController.h"

@interface InsideObjCTableViewController ()

@end

@implementation InsideObjCTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.items = @[
                   @{@"title" : @"01-IMP手动调用SEL", @"controller" : [IMPCallSelectorDemoController new]},
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
