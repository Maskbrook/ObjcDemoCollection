//
//  KVOTableViewController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/20.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "KVOTableViewController.h"
#import "BaseTableViewCell.h"
#import "KVO_Observer.h"
#import "NSObject+KVO_Block.h"

@interface KVOTableViewController ()

@end

@implementation KVOTableViewController
{
    UILabel *_tableHeaderView;
    KVO_Observer *offsetObserver;
}

#pragma mark ## lifeCycle ##

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.items = @[
                   @"# 不要把动画代码放入viewDidLoad中，而是应该放入viewDidAppear中.",
                   @"# 即使是使用ARC，也应该在controller的dealloc方法中将用到的delegate赋值为nil，否则程序有可能崩溃.",
                   @"# 应该把手势识别的代码放入viewDidAppear中，而不是viewDidLoad.",
                   @"# 不要在viewdidload中操作auto layout，而应该在viewDidAppear中操作.",
                   @"# 比较NSString时，不要用==,要用isEqualToString:方法.",
                   @"# 对于UI对象不要赋予非整数的坐标，否则图像可能会模糊",
                   ].mutableCopy;
    
    // tableView Header
    _tableHeaderView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    _tableHeaderView.backgroundColor = RGBA(211, 203, 211, 1.0);
    _tableHeaderView.textAlignment = NSTextAlignmentCenter;
    _tableHeaderView.numberOfLines = 0;
    _tableHeaderView.text = @"KVO监听tableView滚动,\n隐藏navigationBar";
    self.tableView.tableHeaderView = _tableHeaderView;
    
    // KVO方式一
//    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    // KVO方式二
//    offsetObserver = [KVO_Observer observerWithObject:self.tableView keyPath:@"contentOffset" target:self selector:@selector(tableViewContentOffsetChanged)];
    offsetObserver = [[KVO_Observer alloc] initWithObject:self.tableView keyPath:@"contentOffset" target:self selector:@selector(tableViewContentOffsetChanged)];
    
    // KVO方式三
    [self.tableView HC_addObserver:self forKeyPath:@"contentOffset" handleBlock:^(id observedObject, NSString *observedKeyPath, id oldValue, id newValue) {
        CGFloat offset = self.tableView.contentOffset.y;
        CGFloat delta = offset / 64.f + 1.f;
        delta = MAX(0, delta);
        [self.navigationController navigationBar].alpha = 1 - MIN(1, delta);
    }];
}

- (void)tableViewContentOffsetChanged
{
    CGFloat offset = self.tableView.contentOffset.y;
    CGFloat delta = offset / 64.f + 1.f;
    delta = MAX(0, delta);
    [self.navigationController navigationBar].alpha = 1 - MIN(1, delta);
}

/*
// 方式一实现KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    CGFloat offset = self.tableView.contentOffset.y;
    CGFloat delta = offset / 64.f + 1.f;
    delta = MAX(0, delta);
    [self.navigationController navigationBar].alpha = 1 - MIN(1, delta);
}
 */

- (void)dealloc
{
//    [self removeObserver:self forKeyPath:@"contentOffset"];
    [self.tableView HC_removeObserver:self forKeyPath:@"contentOffset"];
}

#pragma mark ## tableView methods ##
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableViewCell *cell = [BaseTableViewCell cellWithTableView:tableView];
    cell.nameLabel.text = [self.items objectAtIndex:indexPath.row];
    return cell;
}

@end
