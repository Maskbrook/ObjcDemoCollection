//
//  DatePickerViewController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/2/11.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "DatePickerViewController.h"
#import "UIButton+blockAction.h"
#import "HYDDatePickerView.h"

@interface DatePickerViewController ()

@property (nonatomic, strong) UIButton *showMenuButton;
@property (nonatomic, strong) HYDDatePickerView *picker;

@end

@implementation DatePickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.showMenuButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    self.showMenuButton.backgroundColor = [UIColor magentaColor];
    [self.showMenuButton setTitle:@"show" forState:UIControlStateNormal];
    [self.view addSubview:self.showMenuButton];
    
    __typeof(self) weakSelf = self;
    self.showMenuButton.actionBlock = ^{
        weakSelf.picker = [[HYDDatePickerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [weakSelf.view addSubview:weakSelf.picker];
        weakSelf.picker.HYDDatePickerViewConfimrBlock = ^(UIButton *sender) {
            NSLog(@"------");
        };
    };
}
@end
