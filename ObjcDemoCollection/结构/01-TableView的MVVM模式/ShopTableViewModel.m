//
//  ShopTableViewModel.m
//  ObjcDemoCollection
//
//  Created by 张家宝 on 2018/2/4.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "ShopTableViewModel.h"
#import "ShopData.h"
#import "ShopTableViewCell.h"

@interface ShopTableViewModel ()

@property (nonatomic, strong) NSArray *shops;

@end

@implementation ShopTableViewModel

- (NSArray *)shops
{
    if (_shops == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"shops.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *shopArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            ShopData *shop = [ShopData shopWithDict:dict];
            [shopArray addObject:shop];
        }
        _shops = shopArray;
    }
    return _shops;
}

- (void)configureDatasourceAndDelegateForTableView:(UITableView *)tableView
{
    tableView.dataSource = self;
    tableView.delegate = self;
}

#pragma mark - tableView methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shops.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopTableViewCell *cell = [ShopTableViewCell cellWithTableView:tableView];
    cell.data = self.shops[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:false];
    ShopData *item = self.shops[indexPath.row];
    if (self.selectCellBlock) {
        self.selectCellBlock(indexPath, item);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.setCellHeightBlock) {
        return  self.setCellHeightBlock();
    }
    return 44.0;
}

@end
