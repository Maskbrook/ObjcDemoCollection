//
//  CellConfigTableViewController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/4/19.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "CellConfigTableViewController.h"
#import "UserInfoCellConfig.h"
#import "UserInfoTableViewCell.h"

@interface CellConfigTableViewController ()

@property (nonatomic, copy) NSArray *dataSource;

@end

@implementation CellConfigTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuserId = [NSString stringWithFormat:@"index_%ld",indexPath.row];
    UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserId];
    if (!cell) {
        UserInfoCellConfig *config =self.dataSource[indexPath.row];
        cell = [[UserInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserId indexPath:indexPath config:config];
    }
    return cell;
}


#pragma mark - getters
- (NSArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [UserInfoCellConfig getConfig];
    }
    return _dataSource;
}


@end
