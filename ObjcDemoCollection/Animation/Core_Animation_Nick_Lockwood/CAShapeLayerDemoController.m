//
//  CAShapeLayerDemoController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/1/15.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "CAShapeLayerDemoController.h"

static const CGFloat kRectViewWidth = 200;
static const CGFloat kRectViewHeight = 70;

@interface CAShapeLayerDemoController ()

@property (nonatomic, strong) UIView *matchstickManView;
@property (nonatomic, strong) UIView *rectView;

@end

@implementation CAShapeLayerDemoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutPageSubviews];
    
    [self drawMatchstickMan];
    [self customRectViewCornerRadius];
}

#pragma mark - private methods
- (void)layoutPageSubviews
{
    [self.view addSubview:self.matchstickManView];
    [self.matchstickManView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.with.height.equalTo(@(300));
        make.top.equalTo(self.view.mas_top).offset(100);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.view addSubview:self.rectView];
    [self.rectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(70);
        make.top.equalTo(self.matchstickManView.mas_bottom).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}

- (void)drawMatchstickMan
{
    // setup bezier path
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(175, 100)];
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    // setup shapeLayer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5.0;
    shapeLayer.path = path.CGPath;
    [self.matchstickManView.layer addSublayer:shapeLayer];
}

- (void)customRectViewCornerRadius
{
    CGRect rect = CGRectMake(0, 0, kRectViewWidth, kRectViewHeight);
    CGSize radii = CGSizeMake(20, 20);
    UIRectCorner corners = UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomRight;
    
    // create bezier path
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    
    // setup shapeLayer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    self.rectView.layer.mask = shapeLayer;
}

#pragma mark - getters
- (UIView *)matchstickManView
{
    if (_matchstickManView == nil) {
        _matchstickManView = [[UIView alloc] init];
        _matchstickManView.backgroundColor = [UIColor lightGrayColor];
    }
    return _matchstickManView;
}

- (UIView *)rectView
{
    if (_rectView == nil) {
        _rectView = [[UIView alloc] init];
        _rectView.backgroundColor = [UIColor redColor];
    }
    return _rectView;
}

@end
