//
//  CollectionLayoutTypesController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/3/26.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "CollectionLayoutTypesController.h"
#import "BaseTableViewCell.h"
#import "LineflowController.h"
#import "WaterflowController.h"

@interface CollectionLayoutTypesController ()

@end

@implementation CollectionLayoutTypesController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.items = @[
                      @{@"title" : @"02-collectionView瀑布流布局", @"controller" : [WaterflowController new]},
                      @{@"title" : @"03-collectionView流水布局", @"controller" : [LineflowController new]},
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
