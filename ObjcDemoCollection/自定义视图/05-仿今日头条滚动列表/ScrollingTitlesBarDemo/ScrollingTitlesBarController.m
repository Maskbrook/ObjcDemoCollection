//
//  ScrollingTitlesBarController.m
//  ObjectiveCSummmaryDemo
//
//  Created by jiabaozhang on 17/5/17.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "ScrollingTitlesBarController.h"

@interface ScrollingTitlesBarController ()

@property (strong, nonatomic) NSArray *demos;

@end

@implementation ScrollingTitlesBarController

#pragma mark - 懒加载
- (NSArray *)demos {
    if (_demos == nil) {
        _demos = @[@"腾讯",@"今日头条", @"网易"];
    }
    
    return _demos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - tableView数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.demos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.demos[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    NSString *className = @"";
    
    switch (indexPath.row) {
        case 0:
            className = @"TencentViewController";
            break;
            
        case 1:
            className = @"ToutiaoViewController";
            break;
            
        case 2:
            className = @"NetsViewController";
            break;
            
        default:
            break;
    }
    
    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
