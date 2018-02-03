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
#import "CustomViewsController.h"
#import "UtilityTableViewController.h"
#import "AnimiationTableViewController.h"
#import "InsideObjCTableViewController.h"
#import "ArchitectureController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"首页";
    self.items = @[
                   @{@"title" : @"Custom Views", @"controller" : [CustomViewsController new]},
                   @{@"title" : @"Utilities", @"controller" : [UtilityTableViewController new]},
                   @{@"title" : @"Animations", @"controller" : [AnimiationTableViewController new]},
                   @{@"title" : @"Inside Objc", @"controller" : [InsideObjCTableViewController new]},
                   @{@"title" : @"Architecture", @"controller" : [ArchitectureController new]},
                   
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

@end
