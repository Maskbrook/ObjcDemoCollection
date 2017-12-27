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
#import "ContainsPointDemoController.h"
#import "ShadowDemoController.h"
#import "MaskLayerDemoController.h"
#import "StretchFilterDemoController.h"
#import "BaseTableViewCell.h"

@interface CoreAnimationBasicController ()

@end

@implementation CoreAnimationBasicController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.items = @[
                   @{@"title" : @"内容拼接", @"controller" : [ContentsDemoController new]},
                   @{@"title" : @"锚点与简单时钟动画", @"controller" : [GeometryDemoController new]},
                   @{@"title" : @"containsPoint, hitTest", @"controller" : [ContainsPointDemoController new]},
                   @{@"title" : @"自定义阴影", @"controller" : [ShadowDemoController new]},
                   @{@"title" : @"图层蒙板", @"controller" : [MaskLayerDemoController new]},
                   @{@"title" : @"拉伸过滤", @"controller" : [StretchFilterDemoController new]},
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
