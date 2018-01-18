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
    
//    [self replicateLayersDemo];
    [self reflectionLayerDemo];
}

#pragma mark - handle replicate layers
// 重复图层
- (void)replicateLayersDemo
{
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:replicator];
    
    replicator.instanceCount = 5;
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 5, 0);
    transform = CATransform3DRotate(transform, M_PI/10.0, 0, 0, 1);
    replicator.instanceTransform = transform;
    
    replicator.instanceBlueOffset = 0.1;
    replicator.instanceRedOffset = -0.1;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(200, 50, 50, 50);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [replicator addSublayer:layer];
}

// 反射
- (void)reflectionLayerDemo
{
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:replicator];
    
    replicator.instanceCount = 2;
    replicator.instanceAlphaOffset = -0.6;
    
    CATransform3D transform = CATransform3DIdentity;
    CGFloat verticalOffset = 150;
    transform = CATransform3DTranslate(transform, 0, verticalOffset, 0);
    transform = CATransform3DScale(transform, 1, -1, 0);
    replicator.instanceTransform = transform;
    
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.frame = CGRectMake(100, 100, 150, 150);
    layer.contents = (__bridge id)([UIImage imageNamed:@"Igloo"]).CGImage;
    layer.contentsScale = [UIScreen mainScreen].scale;
    [replicator addSublayer:layer];
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
