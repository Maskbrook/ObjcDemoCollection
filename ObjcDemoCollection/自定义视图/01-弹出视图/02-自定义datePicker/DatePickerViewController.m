//
//  DatePickerViewController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/2/11.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "DatePickerViewController.h"
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
        weakSelf.picker = [HYDDatePickerView datePickerView];
        [weakSelf.picker showInView:[UIApplication sharedApplication].keyWindow handler:^(NSString *dateString) {
            NSLog(@"%@",dateString);
        }];
    };
}
@end
