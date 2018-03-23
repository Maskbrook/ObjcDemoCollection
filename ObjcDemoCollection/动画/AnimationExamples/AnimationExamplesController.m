//
//  AnimationExamplesController.m
//  ObjcDemoCollection
//
//  Created by 张家宝 on 2018/2/4.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "AnimationExamplesController.h"
#import "WechatLoginController.h"
#import "BaseTableViewCell.h"

@interface AnimationExamplesController ()

@end

@implementation AnimationExamplesController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.items = @[
                   @{@"title" : @"01-微信登录转场动画", @"controller" : [WechatLoginController new],},
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
