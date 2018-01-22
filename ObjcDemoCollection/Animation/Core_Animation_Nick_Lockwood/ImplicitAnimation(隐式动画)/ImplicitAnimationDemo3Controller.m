//
//  ImplicitAnimationDemo3Controller.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/1/22.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "ImplicitAnimationDemo3Controller.h"

@interface ImplicitAnimationDemo3Controller ()

@end

@implementation ImplicitAnimationDemo3Controller
{
    UIView *_containerView;
    UIButton *_changeButton;
    CALayer *_colorLayer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutPageSubviews];
}

#pragma mark - layout subViews
- (void)layoutPageSubviews
{
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _containerView.center = self.view.center;
    _containerView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_containerView];
    
    _colorLayer = [CALayer layer];
    _colorLayer.frame = CGRectMake(0, 0, 100, 100);
    _colorLayer.backgroundColor = [UIColor redColor].CGColor;
    _colorLayer.position = CGPointMake(100, 100);
    [_containerView.layer addSublayer:_colorLayer];
    
    _changeButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 160, 140, 40)];
    _changeButton.backgroundColor = kThemeColor;
    [_changeButton setTitle:@"变~~" forState:UIControlStateNormal];
    [_changeButton addTarget:self action:@selector(tapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_changeButton];
}

#pragma mark - event response
- (void)tapButtonAction:(UIButton *)sender
{
    //add a custom action
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    _colorLayer.actions = @{@"backgroundColor": transition};
    
    //randomize the layer background color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    _colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
}


@end
