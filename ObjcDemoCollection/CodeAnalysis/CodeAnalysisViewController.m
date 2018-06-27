//
//  CodeAnalysisViewController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/5/21.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "CodeAnalysisViewController.h"
#import "BaseTableViewCell.h"
#import "MasonryViewController.h"

@interface CodeAnalysisViewController ()

@end

@implementation CodeAnalysisViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"首页";
    self.items = @[
                   @{@"title" : @"Masonry", @"controller" : [MasonryViewController new]},
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
