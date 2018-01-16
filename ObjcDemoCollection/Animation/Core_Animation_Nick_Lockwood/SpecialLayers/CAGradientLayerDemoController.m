//
//  CAGradientLayerDemoController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/1/16.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "CAGradientLayerDemoController.h"

@interface CAGradientLayerDemoController ()

@end

@implementation CAGradientLayerDemoController
{
    UIView *basicGradientView;
    UIView *mutipleGradientView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutPageSubviews];
    
    [self basicGradientView];
    [self mutipleGradientView];
}

#pragma mark - private methods
//
- (void)layoutPageSubviews
{
    basicGradientView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 150, 150)];
    basicGradientView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:basicGradientView];
    
    mutipleGradientView = [[UIView alloc] initWithFrame:CGRectMake(100, 280, 150, 150)];
    mutipleGradientView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:mutipleGradientView];
}

// 基础渐变
- (void)basicGradientView
{
    // Step 1: create and add layer
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = basicGradientView.bounds;
    [basicGradientView.layer addSublayer:layer];
    
    // Step 2: set colors
    layer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blueColor].CGColor, (__bridge id)[UIColor blackColor].CGColor];
    
    // Step 3: set start and end points
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1.0, 1.0);
}

// 多重渐变
- (void)mutipleGradientView
{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = mutipleGradientView.bounds;
    [mutipleGradientView.layer addSublayer:layer];
    
    layer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                     (__bridge id)[UIColor orangeColor].CGColor,
                     (__bridge id)[UIColor yellowColor].CGColor,
                     (__bridge id)[UIColor greenColor].CGColor,
                     (__bridge id)[UIColor blueColor].CGColor,
                     (__bridge id)[UIColor purpleColor].CGColor];
    
    // locations数组定义了colors属性中每个不同颜色的位置
    // locations数组与colors数组元素个数必须相等，不然渐变无效
    layer.locations = @[@0.0, @0.2, @0.4, @0.6, @0.8, @1.0];
    
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1.0, 1.0);
}

@end
