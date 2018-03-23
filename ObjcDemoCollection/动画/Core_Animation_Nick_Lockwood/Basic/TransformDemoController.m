//
//  TransformDemoController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/29.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "TransformDemoController.h"

static const CGFloat kButtonWidth = 90.0;
static const CGFloat kButtonHeight = 40.0;
static const CGFloat kPadding = 15.0;

@interface TransformDemoController ()

@property (nonatomic, strong) UIView *layerView;
@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UIButton *scaleButton;
@property (nonatomic, strong) UIButton *rotateButton;
@property (nonatomic, strong) UIButton *translateButton;
@property (nonatomic, strong) UIButton *recoverButton; // 恢复到初始状态

@end

@implementation TransformDemoController
/*
 
 1.
 CGAffineTransform 与 CATransform3D
 CALayer.affineTransform执行操作等价于UIView.transform，它们都是CGAffineTransform类型
 CAlayer.transform属性其实是一个CATransform3D类型
 即：
 CALayer.transform ---> CATransform3D
 UIView.transform ---> CGAffineTransform
 CALayer.affineTransform ---> CGAffineTransform
 
 2.
 CGAffineTransform 一般用于2D操作，如在 UIView中。
 而CATransform3D 一般用于操作view的layer的，是 Core Animation的结构体,可以用来做比较复杂的3D操作。
 
 3.
 CGAffineTransform
 （1）四种常见变化：
 旋转、缩放、平移、斜切
 
 （2）参数介绍：
 a, d : 缩放
 b, c : 旋转
 tx, ty : 平移
 
 CGAffineTransform类型属于Core Graphics框架，Core Graphics实际上是一个严格意义上的2D绘图API，并且CGAffineTransform仅仅对2D变换有效。
 
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self layoutPageSubviews];
}

#pragma mark - Private Methods
- (void)layoutPageSubviews
{
    WS(ws);
    
    // set up matrix image
    UIImageView *matrixImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"matrix_affineTransform_3x3"]];
    [self.view addSubview:matrixImg];
    [matrixImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(270));
        make.height.equalTo(@(90));
        make.top.mas_equalTo(ws.view.mas_top).offset(70);
        make.centerX.mas_equalTo(ws.view.mas_centerX);
    }];
    
    
    // set up layer
    self.layerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    self.layerView.center = self.view.center;
    self.layerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.layerView];
    
    UIImage *image = [UIImage imageNamed:@"Snowman"];
    self.layerView.layer.contents = (__bridge id)image.CGImage;
    self.layerView.layer.contentsGravity = kCAGravityResizeAspectFill;
    self.layerView.layer.contentsScale = image.scale;
    
    // set up buttons
    self.scaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.scaleButton.backgroundColor = kThemeColor;
    [self.scaleButton addTarget:self action:@selector(scaleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scaleButton setTitle:@"缩放(a, d)" forState:UIControlStateNormal];
    [self.view addSubview:self.scaleButton];
    
    self.rotateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rotateButton.backgroundColor = kThemeColor;
    [self.rotateButton addTarget:self action:@selector(rotateButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.rotateButton setTitle:@"旋转(b, c)" forState:UIControlStateNormal];
    [self.view addSubview:self.rotateButton];
    
    self.translateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.translateButton.backgroundColor = kThemeColor;
     [self.translateButton addTarget:self action:@selector(translateButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.translateButton setTitle:@"平移(tx, ty)" forState:UIControlStateNormal];
    [self.view addSubview:self.translateButton];
    
    self.recoverButton= [UIButton buttonWithType:UIButtonTypeCustom];
    self.recoverButton.backgroundColor = kThemeColor;
    [self.recoverButton addTarget:self action:@selector(recoverButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.recoverButton setTitle:@"初始状态" forState:UIControlStateNormal];
    [self.view addSubview:self.recoverButton];
    
    // layout buttons
    [self.scaleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonHeight));
        make.centerX.mas_equalTo(ws.view.mas_centerX);
        make.bottom.mas_equalTo(ws.view.mas_bottom).offset(-kPadding);
    }];
    
    [self.rotateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonHeight));
        make.left.mas_equalTo(ws.scaleButton.mas_right).offset(kPadding);
        make.bottom.mas_equalTo(ws.view.mas_bottom).offset(-kPadding);
    }];
    
    [self.translateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonHeight));
        make.right.mas_equalTo(ws.scaleButton.mas_left).offset(-kPadding);
        make.bottom.mas_equalTo(ws.view.mas_bottom).offset(-kPadding);
    }];
    
    [self.recoverButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonHeight));
        make.centerX.mas_equalTo(ws.view.mas_centerX);
        make.bottom.mas_equalTo(ws.scaleButton.mas_top).offset(-kPadding);
    }];
}

#pragma mark - Touch Events
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    point = [self.layerView.layer convertPoint:point fromLayer:self.view.layer];
    if ([self.layerView.layer containsPoint:point]) {
        self.layerView.transform = CGAffineTransformRotate(self.layerView.transform, M_PI_4);
//        self.layerView.layer.affineTransform = CGAffineTransformRotate(self.layerView.layer.affineTransform, M_PI_4);
//        self.layerView.layer.transform = CATransform3DMakeRotation(M_PI_4, 5, 5, 5);
    }
}


#pragma mark - Button Events
- (void)scaleButtonAction:(UIButton *)sender
{
    self.layerView.layer.affineTransform = HC_CGAffineTransformMakeScale(1.5, -0.5);
}

- (void)rotateButtonAction:(UIButton *)sender
{
    self.layerView.layer.affineTransform = HC_CGAffineTransformMakeRotation(0, -1);
}

- (void)translateButtonAction:(UIButton *)sender
{
    self.layerView.layer.affineTransform = HC_CGAffineTransformMakeTranslation(50, -50);
}

- (void)recoverButtonAction:(UIButton *)sender
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    self.layerView.layer.affineTransform = transform;
}

#pragma mark - Custom Transform Methods

/*
 
 | a,  b,  0 |
 | c,  d,  0 |
 | tx, ty, 1 |
 
 
                        | a,  b,  0 |
 {x',y',1} = {x,y,1} x  | c,  d,  0 |
                        | tx, ty, 1 |
 
 */

/**
 执行平移
 若view移动之前的坐标为(x, y)，则执行函数后变为(x+tx, y+ty)
 */
static CGAffineTransform HC_CGAffineTransformMakeTranslation(CGFloat tx, CGFloat ty)
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.tx = tx;
    transform.ty = ty;
    return transform;
}

/**
 执行旋转
 */
static CGAffineTransform HC_CGAffineTransformMakeRotation(CGFloat b, CGFloat c)
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.b = b;
    transform.c = c;
    return transform;
}


/**
 执行缩放

 @param a 宽度缩放比例
 @param d 高度缩放比例
 若初始大小为(w, h),则缩放后变为(w * a, h * b)
 负数值则变为轴对称
 */
static CGAffineTransform HC_CGAffineTransformMakeScale(CGFloat a, CGFloat d)
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.a = a;
    transform.d = d;
    return transform;
}

@end
