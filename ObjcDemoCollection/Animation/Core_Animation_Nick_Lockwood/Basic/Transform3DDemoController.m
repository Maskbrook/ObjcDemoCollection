//
//  Transform3DDemoController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/29.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "Transform3DDemoController.h"

static const CGFloat kButtonWidth = 90.0;
static const CGFloat kButtonHeight = 40.0;
static const CGFloat kPadding = 15.0;

@interface Transform3DDemoController ()
// common ui
@property (nonatomic, strong) UIButton *recoverButton; // 恢复到初始状态

// for testing single layer
@property (nonatomic, strong) UIView *layerView;

// for testing parallel layers
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *layerViewleft;
@property (nonatomic, strong) UIView *layerViewRight;

// for testing nesting layers
@property (nonatomic, strong) UIView *outerLayerView;
@property (nonatomic, strong) UIView *innerLayerView;

@end

@implementation Transform3DDemoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self layoutCommonPageSubviews];
    
//    [self layoutSingleLayer];
//    [self layoutParellelLayers];
    [self layoutNestingLayers];
}


#pragma mark - Private Methods

- (void)layoutNestingLayers
{
    self.outerLayerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 180)];
    self.outerLayerView.center = self.view.center;
    self.outerLayerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.outerLayerView];
    
    self.innerLayerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    self.innerLayerView.center = self.view.center;
    self.innerLayerView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.innerLayerView];
    
    UILabel *innerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 80, 40)];
    innerLabel.backgroundColor = [UIColor redColor];
    innerLabel.text = @"Inner";
    innerLabel.textColor = [UIColor whiteColor];
    innerLabel.textAlignment = NSTextAlignmentCenter;
    [self.innerLayerView addSubview:innerLabel];
}

- (void)layoutParellelLayers
{
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 140)];
    self.containerView.backgroundColor = [UIColor blueColor];
    self.containerView.center = self.view.center;
    [self.view addSubview:self.containerView];
    
    UIImage *image = [UIImage imageNamed:@"Snowman"];
    self.layerViewleft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 140)];
    self.layerViewleft.backgroundColor = [UIColor whiteColor];
    [self.containerView addSubview:self.layerViewleft];
    self.layerViewleft.layer.contents = (__bridge id)image.CGImage;
    self.layerViewleft.layer.contentsGravity = kCAGravityResizeAspectFill;
    self.layerViewleft.layer.contentsScale = image.scale;
    
    self.layerViewRight = [[UIView alloc] initWithFrame:CGRectMake(160, 0, 140, 140)];
    self.layerViewRight.backgroundColor = [UIColor whiteColor];
    [self.containerView addSubview:self.layerViewRight];
    self.layerViewRight.layer.contents = (__bridge id)image.CGImage;
    self.layerViewRight.layer.contentsGravity = kCAGravityResizeAspectFill;
    self.layerViewRight.layer.contentsScale = image.scale;
}

- (void)layoutSingleLayer
{
    // set up layer
    self.layerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    self.layerView.center = self.view.center;
    self.layerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.layerView];
    
    UIImage *image = [UIImage imageNamed:@"Snowman"];
    self.layerView.layer.contents = (__bridge id)image.CGImage;
    self.layerView.layer.contentsGravity = kCAGravityResizeAspectFill;
    self.layerView.layer.contentsScale = image.scale;
}

- (void)layoutCommonPageSubviews
{
    WS(ws);
    // set up matrix image
    UIImageView *matrixImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"matrix_transform3D_4x4"]];
    [self.view addSubview:matrixImg];
    [matrixImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(270));
        make.height.equalTo(@(90));
        make.top.mas_equalTo(ws.view.mas_top).offset(70);
        make.centerX.mas_equalTo(ws.view.mas_centerX);
    }];
    
    // set up buttons
    self.recoverButton= [UIButton buttonWithType:UIButtonTypeCustom];
    self.recoverButton.backgroundColor = kThemeColor;
    [self.recoverButton addTarget:self action:@selector(recoverButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.recoverButton setTitle:@"初始状态" forState:UIControlStateNormal];
    [self.view addSubview:self.recoverButton];
    [self.recoverButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonHeight));
        make.centerX.mas_equalTo(ws.view.mas_centerX);
        make.bottom.mas_equalTo(ws.view.mas_bottom).offset(-kPadding);
    }];
}

#pragma mark - Touch Events
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // single layer
    CGPoint point = [[touches anyObject] locationInView:self.view];
    CGPoint layePpoint = [self.layerView.layer convertPoint:point fromLayer:self.view.layer];
    if ([self.layerView.layer containsPoint:layePpoint]) {
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1 / 500;
        transform = CATransform3DRotate(transform, M_PI_4, 1, 1, 0);
        self.layerView.layer.transform = transform;
    }
    
    
    // for parellel layers
    CGPoint layerLeftPoint = [self.layerViewleft.layer convertPoint:point fromLayer:self.view.layer];
    if ([self.layerViewleft.layer containsPoint:layerLeftPoint]) {
        CATransform3D perspective = CATransform3DIdentity;
        perspective.m34 = - 1.0 / 500.0;
        // CALayer有一个属性叫做sublayerTransform。它也是CATransform3D类型，但和对一个图层的变换不同，它影响到所有的子图层。这意味着你可以一次性对包含这些图层的容器做变换，于是所有的子图层都自动继承了这个变换方法。
        // 主要用于统一各个子图层的灭点
        self.containerView.layer.sublayerTransform = perspective;
        CATransform3D transform1 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
        self.layerViewleft.layer.transform = transform1;
        CATransform3D transform2 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
        self.layerViewRight.layer.transform = transform2;
    }
    
    // for nesting layers
    CGPoint innerPoint = [self.layerViewleft.layer convertPoint:point fromLayer:self.view.layer];
    if ([self.innerLayerView.layer containsPoint:innerPoint]) {
        //
        CATransform3D outer = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
        self.outerLayerView.layer.transform = outer;
        CATransform3D inner = CATransform3DMakeRotation(-M_PI_2, 0, 0, 1);
        self.innerLayerView.layer.transform = inner;
        
        outer = CATransform3DIdentity;
        outer.m34 = -1.0 / 500.0;
        outer = CATransform3DRotate(outer, M_PI_4, 0, 1, 0);
        self.outerLayerView.layer.transform = outer;
        inner = CATransform3DIdentity;
        inner.m34 = -1.0 / 500.0;
        inner = CATransform3DRotate(inner, -M_PI_4, 0, 1, 0);
        self.innerLayerView.layer.transform = inner;
    }
}

#pragma mark - Button Events
- (void)recoverButtonAction:(UIButton *)sender
{
    CATransform3D transform = CATransform3DIdentity;
    self.layerView.layer.transform = transform;
    self.layerViewleft.layer.transform = transform;
    self.layerViewRight.layer.transform = transform;
    self.innerLayerView.layer.transform = transform;
    self.outerLayerView.layer.transform = transform;
}

@end
