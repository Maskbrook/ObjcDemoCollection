//
//  ImplicitAnimationDemoController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/1/22.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "ImplicitAnimationDemoController.h"

@interface ImplicitAnimationDemoController ()

@end

@implementation ImplicitAnimationDemoController
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
//    [self basicCATransaction];
    [self transactionWithCompleteBlock];
}

#pragma mark - CATransaction Types
// 开启 并 提交 一个事务
- (void)basicCATransaction
{
    // 开启一个新事务
    // 起一个新的事务，修改时间就不会有别的副作用。因为修改当前事务的时间可能会导致同一时刻别的动画（如屏幕旋转），所以最好还是在调整动画之前压入一个新的事务。
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    _colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    // 提交事务
    [CATransaction commit];
}

// 动画完成之后，添加一个回调
- (void)transactionWithCompleteBlock
{
    // 开启一个新事务
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    
    // 动画完成之后，添加一个回调
    [CATransaction setCompletionBlock:^{
        CGAffineTransform transform = _colorLayer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI/4);
        _colorLayer.affineTransform = transform;
    }];
    
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    _colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    // 提交事务
    [CATransaction commit];
}


@end
