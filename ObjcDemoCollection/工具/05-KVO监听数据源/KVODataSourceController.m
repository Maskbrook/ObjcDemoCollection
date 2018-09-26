//
//  KVODataSourceController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/6/27.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "KVODataSourceController.h"
#import "HYDRedPacketSegmentControl.h"
#import "RedPacketModel.h"
#import <objc/runtime.h>

@interface KVODataSourceController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) HYDRedPacketSegmentControl *segmentControl;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <RedPacketModel *> *dataArray;
@end

@implementation KVODataSourceController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutPageSubviews];
    
    [self.segmentControl addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew context:nil];
    [self.tableView addObserver:self forKeyPath:@"dataSource" options:NSKeyValueObservingOptionNew context:nil];
    
    NSArray *arr = [self getAllProperties];
    NSLog(@"%@", arr);
}

#pragma mark - private
- (NSArray *)getAllProperties
{
    unsigned int count;
    objc_property_t *properties =class_copyPropertyList([UITableView class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++) {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}

- (void)layoutPageSubviews
{
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.tableView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (object == self.segmentControl && [keyPath isEqualToString:@"selectedIndex"]) {
        NSLog(@"============>>%zd", self.segmentControl.selectedIndex);
        if (self.segmentControl.selectedIndex == 0) {
            RedPacketModel *m1 = [[RedPacketModel alloc] initWithName:@"还款红包" detail:@"288元"];
            RedPacketModel *m2 = [[RedPacketModel alloc] initWithName:@"还款红包2" detail:@"188元"];
            RedPacketModel *m3 = [[RedPacketModel alloc] initWithName:@"还款红包3" detail:@"88元"];
            self.dataArray = @[m1, m2, m3];
        } else if (self.segmentControl.selectedIndex == 1) {
            RedPacketModel *m1 = [[RedPacketModel alloc] initWithName:@"借款红包" detail:@"99元"];
            RedPacketModel *m2 = [[RedPacketModel alloc] initWithName:@"借款红包2" detail:@"199元"];
            RedPacketModel *m3 = [[RedPacketModel alloc] initWithName:@"借款红包3" detail:@"299元"];
            self.dataArray = @[m1, m2, m3];
        } else {
            self.dataArray = nil;
        }
        [self.tableView reloadData];
    }
}

- (void)dealloc
{
    
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = ((RedPacketModel *)self.dataArray[indexPath.row]).name;
    cell.detailTextLabel.text = ((RedPacketModel *)self.dataArray[indexPath.row]).detail;
    return cell;
}

#pragma mark - setters
- (HYDRedPacketSegmentControl *)segmentControl
{
    if (_segmentControl == nil) {
        CGFloat topOffset = iPhoneX ? 88 : 64;
        WS(ws);
        _segmentControl = [[HYDRedPacketSegmentControl alloc] initWithFrame:CGRectMake(0, topOffset, SCREEN_WIDTH, 44) titles:@[@"未使用", @"已使用", @"已过期"]];
        [_segmentControl setDefaultSelectedIndex:0];
        [_segmentControl setSelectIndexActionBlock:^(NSInteger index) {
            ws.segmentControl.selectedIndex = index;
        }];
    }
    return _segmentControl;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        CGFloat topOffset = iPhoneX ? 88+44 : 64+44;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topOffset, SCREEN_WIDTH, SCREEN_HEIGHT-topOffset) style:UITableViewStylePlain];
    }
    return _tableView;
}

-(NSArray<RedPacketModel *> *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = @[];
    }
    return _dataArray;
}

@end
