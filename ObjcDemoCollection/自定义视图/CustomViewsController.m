//
//  CustomViewsController.m
//  ObjcDemoCollection
//
//  Created by 张家宝 on 2018/2/4.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "CustomViewsController.h"
#import "BaseTableViewCell.h"
//#import "PopMenuController.h"
#import "InfiniteBannerController.h"
#import "CollectionLayoutTypesController.h"
#import "ScrollingTitlesBarController.h"
//#import "DatePickerViewController.h"
#import "ADCollectionsController.h"
#import "PopViewCollectsController.h"

@interface CustomViewsController ()

@end

@implementation CustomViewsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.items = @[
                   @{@"title" : @"01-弹出菜单集合", @"controller" : [PopViewCollectsController new]},
//                   @{@"title" : @"01-仿支付宝弹出菜单View", @"controller" : [PopMenuController new]},
                   @{@"title" : @"04-无线滚动的banner", @"controller" : [InfiniteBannerController new]},
                   @{@"title" : @"05-仿今日头条滚动列表", @"controller" : [ScrollingTitlesBarController new]},
//                   @{@"title" : @"06-自定义时间选择器", @"controller" : [DatePickerViewController new]},
                   @{@"title" : @"07-启动广告、引导图、轮播图", @"controller" : [ADCollectionsController new]},
                   @{@"title" : @"03-CollectionView布局集合", @"controller" : [CollectionLayoutTypesController new]},
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
