//
//  AnimiationTableViewController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/20.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "AnimiationTableViewController.h"
#import "CoreAnimationBasicController.h"
#import "AnimationExamplesController.h"
#import "BaseTableViewCell.h"

@interface AnimiationTableViewController ()

@end

@implementation AnimiationTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.items = @[
                   @{@"title" : @"01-Core Animation, Nick Lockwood", @"controller" : [CoreAnimationBasicController new],},
                   @{@"title" : @"02-项目常用动画效果", @"controller" : [AnimationExamplesController new],},
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
