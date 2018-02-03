//
//  PopMenuController.m
//  ObjectiveCSummmaryDemo
//
//  Created by jiabaozhang on 2017/5/6.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "PopMenuController.h"
#import "PopMenuItem.h"
#import "PopMenuView.h"
#import "UIButton+blockAction.h"

@interface PopMenuController ()

@property (nonatomic, strong) UIButton *showMenuButton;

@end

@implementation PopMenuController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.showMenuButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    self.showMenuButton.backgroundColor = [UIColor magentaColor];
    [self.showMenuButton setTitle:@"show" forState:UIControlStateNormal];
    [self.view addSubview:self.showMenuButton];
    
    __typeof(self) weakSelf = self;
    self.showMenuButton.actionBlock = ^{
        PopMenuItem *item1 = [PopMenuItem itemWithTitle:@"扫一扫" image:[UIImage imageNamed:@"right_menu_QR"] handler:^(PopMenuItem *item) {
            NSLog(@"扫一扫");
        }];
        PopMenuItem *item2 = [PopMenuItem itemWithTitle:@"收付款" image:[UIImage imageNamed:@"right_menu_payMoney"] handler:^(PopMenuItem *item) {
            NSLog(@"收付款");
        }];
        PopMenuItem *item3 = [PopMenuItem itemWithTitle:@"多人聊天" image:[UIImage imageNamed:@"right_menu_multichat"] handler:^(PopMenuItem *item) {
            NSLog(@"多人聊天");
        }];
        PopMenuItem *item4 = [PopMenuItem itemWithTitle:@"面对面收钱" image:[UIImage imageNamed:@"right_menu_facetoface"] handler:^(PopMenuItem *item) {
            NSLog(@"面对面收钱");
        }];
        
        NSArray *items = @[item1, item2, item3, item4];
        
        PopMenuView *menu = [PopMenuView popMenuView];
        CGFloat midx = CGRectGetMidX(weakSelf.showMenuButton.frame);
        CGFloat maxy = CGRectGetMaxY(weakSelf.showMenuButton.frame);
        CGFloat menuWidth = 140.0;
        [menu showItems:items arrow_middle_x:menuWidth/2 menu_original_x:(midx-menuWidth/2) menu_original_y:maxy width:menuWidth];
    };
}

@end
