//
//  ClassicViewsController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/9/26.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "ClassicViewsController.h"
#import "QzoneStrechableHeadController.h"

@interface ClassicViewsController ()

@end

@implementation ClassicViewsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.items = @[
                   @{@"title": @"可拉伸头部控件(类似QQ空间)", @"controller": [QzoneStrechableHeadController new]},
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
