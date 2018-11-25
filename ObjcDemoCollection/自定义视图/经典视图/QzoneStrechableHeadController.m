//
//  QzoneStrechableHeadController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/9/26.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "QzoneStrechableHeadController.h"
#import "UIBarButtonItem+Helper.h"

@interface QzoneStrechableHeadController ()<UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *bgImageView;
@end

@implementation QzoneStrechableHeadController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutPageSubviews];
    [self configNavigationBarStyle];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    //如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)tapLeftItemAction { [self.navigationController popViewControllerAnimated:YES];}
- (void)tapRightItemAction {}

- (void)configNavigationBarStyle
{
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 44, 44)];
    [leftButton setImage:[UIImage imageNamed:@"icon-back-white"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(tapLeftItemAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_HEIGHT-64, 20, 44, 44)];
    [rightButton setImage:[UIImage imageNamed:@"icon-setting-white"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(tapRightItemAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)layoutPageSubviews
{
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        CGFloat topOffset = iPhoneX?-88:-64;
        CGFloat bottomOffset = iPhoneX?39:0;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topOffset, SCREEN_WIDTH, SCREEN_HEIGHT-topOffset-bottomOffset)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 0.6)];
        head.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = head;
    }
    return _tableView;
}

- (UIImageView *)bgImageView
{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 0.6)];
        _bgImageView.image = [UIImage imageNamed:@"someHeader.jpeg"];
    }
    return _bgImageView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd行",indexPath.row];
    return cell;
}

@end
