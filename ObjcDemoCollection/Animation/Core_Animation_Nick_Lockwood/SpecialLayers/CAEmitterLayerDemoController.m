//
//  CAEmitterLayerDemoController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/1/19.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "CAEmitterLayerDemoController.h"

@interface CAEmitterLayerDemoController ()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation CAEmitterLayerDemoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutPageSubviews];
    [self createEmitterLayerDemo];
}

#pragma mark - private methods
- (void)createEmitterLayerDemo
{
    // create and add emitter layer
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:emitter];
    
    // config emitter layer
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width / 2.0, emitter.frame.size.height / 2.0);
    
    // create a particle template
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.contents = (__bridge id)[UIImage imageNamed:@"Spark.png"].CGImage;
    cell.birthRate = 150;
    cell.lifetime = 5.0;
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI * 2.0;
    
    // add particle to emitter
    emitter.emitterCells = @[cell];
}

- (void)layoutPageSubviews
{
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, CGRectGetWidth(self.view.bounds) - 20, CGRectGetHeight(self.view.bounds)-120)];
    self.containerView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.containerView];
}


@end
