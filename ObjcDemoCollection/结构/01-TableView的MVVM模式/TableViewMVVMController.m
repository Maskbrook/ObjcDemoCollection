//
//  TableViewMVVMController.m
//  ObjcDemoCollection
//
//  Created by 张家宝 on 2018/2/4.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "TableViewMVVMController.h"
#import "ShopData.h"
#import "ShopTableViewModel.h"

@interface TableViewMVVMController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ShopTableViewModel *viewModel;

@end

@implementation TableViewMVVMController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutPageSubviews];
}

- (void)layoutPageSubviews
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.viewModel = [[ShopTableViewModel alloc] init];
    [self.viewModel configureDatasourceAndDelegateForTableView:self.tableView];
    
    
    //
    self.viewModel.selectCellBlock = ^(NSIndexPath *path, ShopData *data) {
        NSLog(@"%ld---%@", (long)path.row, data.price);
    };
    
    //
    self.viewModel.setCellHeightBlock = ^CGFloat(){
        return 70.0;
    };
}

@end
