//
//  ImplicitAnimationDemo2Controller.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/1/22.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "ImplicitAnimationDemo2Controller.h"

@interface ImplicitAnimationDemo2Controller ()

@end

@implementation ImplicitAnimationDemo2Controller
{
    UIView *_layerView;
    UIButton *_changeButton;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutPageSubviews];
    [self testImplictAnimation];
}

#pragma mark - layout subViews
- (void)layoutPageSubviews
{
    _layerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _layerView.center = self.view.center;
    _layerView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_layerView];
    
    _changeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 140, 40)];
    CGFloat centerX = self.view.center.x;
    CGFloat centerY = self.view.center.y;
    CGPoint buttonCenter = CGPointMake(centerX, centerY + 150);
    _changeButton.center = buttonCenter;
    _changeButton.backgroundColor = kThemeColor;
    [_changeButton setTitle:@"变~~" forState:UIControlStateNormal];
    [_changeButton addTarget:self action:@selector(tapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_changeButton];
}

#pragma mark - event response
- (void)tapButtonAction:(UIButton *)sender
{
    [self changeColorOfAssociatedLayer];
}

#pragma mark - 改变关联图层的背景色
// 改变关联图层的背景色
// 关联图层：可以理解为UIView.layer
- (void)changeColorOfAssociatedLayer
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0]; // 图层颜色瞬间变化，因为UIView禁用了关联图层的隐式动画
    
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    _layerView.layer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    [CATransaction commit];
}

- (void)testImplictAnimation
{
    //动画块之外修改layer
    NSLog(@"Outside: %@", [_layerView actionForLayer:_layerView.layer forKey:@"backgroundColor"]);
    
    //begin animation block
    [UIView beginAnimations:nil context:nil];
    //动画块内修改layer
    NSLog(@"Inside: %@", [_layerView actionForLayer:_layerView.layer forKey:@"backgroundColor"]);
    //end animation block
    [UIView commitAnimations];
}

@end
