//
//  InfiniteBannerController.m
//  ObjectiveCSummmaryDemo
//
//  Created by jiabaozhang on 2017/5/6.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "InfiniteBannerController.h"
#import "InfiniteBannerView.h"
#import "InfiniteBannerViewItem.h"

@interface InfiniteBannerController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation InfiniteBannerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTableView];
    [self setupTableHeaderView];
    
    /*
    NSArray *urls = @[
                      [NSURL URLWithString:@"http://imagemg.cnpp.cn/upload/images/20161028/10280428816_600x400.jpg"],
                      [NSURL URLWithString:@"http://imagemg.cnpp.cn/upload/images/20161028/10413758057_600x400.jpg"],
                      [NSURL URLWithString:@"http://imagemg.cnpp.cn/upload/images/20161028/10311484626_600x400.jpg"],
                      [NSURL URLWithString:@"http://imagemg.cnpp.cn/upload/images/20161028/10325445758_600x400.jpg"],
                      [NSURL URLWithString:@"http://imagemg.cnpp.cn/upload/images/20161028/10431342856_600x400.jpg"],
                      [NSURL URLWithString:@"http://imagemg.cnpp.cn/upload/images/20161028/10383862642_600x400.jpg"],
                      [NSURL URLWithString:@"http://imagemg.cnpp.cn/upload/images/20161028/10362254466_600x400.jpg"],
                      ];
    
    InfiniteBannerView *bannerView = [[InfiniteBannerView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 180)];
    //不根据controller所在界面的statusbar、navigationbar等，自动调整scrollview的inset
    self.automaticallyAdjustsScrollViewInsets = false;
    bannerView.scrollingInterval = 3.0;
    bannerView.imageUrls = @[
                             [InfiniteBannerViewItem itemWithImageUrl:urls[0] handelr:^(InfiniteBannerViewItem *item) {
                                 NSLog(@"0-->%@",item.imageUrl);
                             }],
                             [InfiniteBannerViewItem itemWithImageUrl:urls[1] handelr:^(InfiniteBannerViewItem *item) {
                                 NSLog(@"0-->%@",item.imageUrl);
                             }],
                             [InfiniteBannerViewItem itemWithImageUrl:urls[2] handelr:^(InfiniteBannerViewItem *item) {
                                 NSLog(@"0-->%@",item.imageUrl);
                             }],
                             [InfiniteBannerViewItem itemWithImageUrl:urls[3] handelr:^(InfiniteBannerViewItem *item) {
                                 NSLog(@"0-->%@",item.imageUrl);
                             }],
                             [InfiniteBannerViewItem itemWithImageUrl:urls[4] handelr:^(InfiniteBannerViewItem *item) {
                                 NSLog(@"0-->%@",item.imageUrl);
                             }],
                             [InfiniteBannerViewItem itemWithImageUrl:urls[5] handelr:^(InfiniteBannerViewItem *item) {
                                 NSLog(@"0-->%@",item.imageUrl);
                             }],
                             [InfiniteBannerViewItem itemWithImageUrl:urls[6] handelr:^(InfiniteBannerViewItem *item) {
                                 NSLog(@"0-->%@",item.imageUrl);
                             }],
                             ];
    [self.view addSubview:bannerView];
     */
}

- (void)setupTableHeaderView
{
    UITableViewHeaderFooterView *header = [[UITableViewHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 180)];
    header.contentView.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = header;
    
    NSArray *urls = @[
                      [NSURL URLWithString:@"http://download.credithc.com/hengyidai/adb9f5e9de674e22a25ffab39597f2ce.png"],
                      [NSURL URLWithString:@"http://download.credithc.com/hengyidai/0ede5441291c430280efe0c7ad8813a4.png"],
                      [NSURL URLWithString:@"http://download.credithc.com/hengyidai/d956ca40a6034e7cb80fc5cd4fa83a03.png"],
                      [NSURL URLWithString:@"http://download.credithc.com/hengyidai/9b7188f14cc74e9fa3a4d318f51bc621.png"],
                      ];
    
    InfiniteBannerView *bannerView = [[InfiniteBannerView alloc] initWithFrame:header.bounds];
    //不根据controller所在界面的statusbar、navigationbar等，自动调整scrollview的inset
//    self.automaticallyAdjustsScrollViewInsets = false;
    bannerView.scrollingInterval = 3.0;
    bannerView.imageUrls = @[
                             [InfiniteBannerViewItem itemWithImageUrl:urls[0] title:@"乔丹" handelr:^(InfiniteBannerViewItem *item) {
                                 NSLog(@"%@", item.title);
                             }],
                             [InfiniteBannerViewItem itemWithImageUrl:urls[1] title:@"詹姆斯" handelr:^(InfiniteBannerViewItem *item) {
                                 NSLog(@"%@", item.title);
                             }],
                             [InfiniteBannerViewItem itemWithImageUrl:urls[2] title:@"贾巴尔" handelr:^(InfiniteBannerViewItem *item) {
                                 NSLog(@"%@", item.title);
                             }],
                             [InfiniteBannerViewItem itemWithImageUrl:urls[3] title:@"魔术师" handelr:^(InfiniteBannerViewItem *item) {
                                 NSLog(@"%@", item.title);
                             }],
                             
                             ];
    [header addSubview:bannerView];
}

- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"无限滚动--%zd", indexPath.row];
    return cell;
}

@end
