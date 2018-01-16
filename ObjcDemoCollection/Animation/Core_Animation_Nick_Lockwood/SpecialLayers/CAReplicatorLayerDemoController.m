//
//  CAReplicatorLayerDemoController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/1/16.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "CAReplicatorLayerDemoController.h"

@interface CAReplicatorLayerDemoController ()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation CAReplicatorLayerDemoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutPageSubviews];
}

#pragma mark - handle replicate layers
// 重复图层
- (void)replicateLayersDemo
{
    
}

// 反射
- (void)reflectionLayerDemo
{
    
}

#pragma mark - private methods
- (void)layoutPageSubviews
{
    [self.view addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(100);
        make.right.bottom.offset(-10);
    }];
}

#pragma mark - getters & getters
- (UIView *)containerView
{
    if (_containerView == nil) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor lightGrayColor];
    }
    return _containerView;
}

@end
