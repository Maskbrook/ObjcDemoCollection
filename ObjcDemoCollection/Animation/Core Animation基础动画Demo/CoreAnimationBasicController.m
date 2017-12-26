//
//  CoreAnimationBasicController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/26.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "CoreAnimationBasicController.h"
#import "ContentsDemoController.h"
#import "GeometryDemoController.h"
#import "BaseTableViewCell.h"

@interface CoreAnimationBasicController ()

@end

@implementation CoreAnimationBasicController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.items = @[
                   @{@"title" : @"contents等概念", @"controller" : [ContentsDemoController new]},
                   @{@"title" : @"frame,bounds,anchorpoint等", @"controller" : [GeometryDemoController new]},
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
