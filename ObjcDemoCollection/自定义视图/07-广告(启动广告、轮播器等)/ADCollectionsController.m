//
//  ADCollectionsController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/3/26.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//  启动广告、引导图、轮播图

#import "ADCollectionsController.h"
#import "BaseTableViewCell.h"
//VC
#import "LeadingPagesController.h"
#import "LaunchAdsController.h"

@interface ADCollectionsController ()

@end

@implementation ADCollectionsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.items = @[
                   @{@"title" : @"01-引导图", @"controller" : [LeadingPagesController new]},
                   @{@"title" : @"02-启动广告", @"controller" : [LaunchAdsController new]},
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
