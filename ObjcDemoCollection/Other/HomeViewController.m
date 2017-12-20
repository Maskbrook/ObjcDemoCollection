//
//  HomeViewController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/20.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "HomeViewController.h"
#import "BaseNavigationController.h"
#import "BaseTableViewCell.h"
#import "UtilityTableViewController.h"
#import "AnimiationTableViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"首页";
    self.items = @[
                   @{@"title" : @"Animation", @"controller" : [AnimiationTableViewController new]},
                   @{@"title" : @"Utility", @"controller" : [UtilityTableViewController new]}
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
    cell.nameLabel.text = [self.items[indexPath.row] valueForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushViewControllerWithIndexPath:indexPath];
}

- (void)pushViewControllerWithIndexPath:(NSIndexPath *)path
{
    NSString *title = [[self.items objectAtIndex:path.row] valueForKey:@"title"];
    UIViewController *controller = [[self.items objectAtIndex:path.row] valueForKey:@"controller"];
    controller.title = title;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
