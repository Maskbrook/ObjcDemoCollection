//
//  IMPCallSelectorDemoController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/28.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "IMPCallSelectorDemoController.h"

@interface IMPCallSelectorDemoController ()

@property (nonatomic, strong) NSMutableArray *buttonsArray;

@end

@implementation IMPCallSelectorDemoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.buttonsArray = @[].mutableCopy;
    [self layoutPageSubviews];
}

- (void)layoutPageSubviews
{
    CGFloat padding = 20;
    CGFloat buttonWidth = 100;
    CGFloat buttonHeight = 40;
    CGFloat buttonX = 100;
    CGFloat buttonY = 0;
    NSString *buttonNameString = @"";
    
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonNameString = [NSString stringWithFormat:@"button %02ld",(long)i+1];
        buttonY = (buttonHeight + padding) * i + 80;
        [button setTitle:buttonNameString forState:UIControlStateNormal];
        button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
        button.backgroundColor = [UIColor redColor];
        [self.view addSubview:button];
        [self.buttonsArray addObject:button];
        [button addTarget:self action:@selector(tapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)tapButtonAction:(UIButton *)sender
{
    SEL selectors[] = {
        @selector(button1Action),
        @selector(button2Action),
        @selector(button3Action),
        @selector(button4Action),
    };
    
    NSInteger selectorIndex = [self.buttonsArray indexOfObject:sender];
    // 根据id和SEL查询方法实现IMP
    void(*imp)(id, SEL) = (typeof (imp))[self methodForSelector:selectors[selectorIndex]];
    // 调用IMP
    imp(self, selectors[selectorIndex]);
    
}

- (void)button1Action{NSLog(@"1");}
- (void)button2Action{NSLog(@"2");}
- (void)button3Action{NSLog(@"3");}
- (void)button4Action{NSLog(@"4");}

@end
