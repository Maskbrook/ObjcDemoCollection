//
//  ShadowDemoController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/27.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "ShadowDemoController.h"

@interface ShadowDemoController ()

@property (nonatomic, strong) UIView *layerView1;
@property (nonatomic, strong) UIView *layerView2;

@end

@implementation ShadowDemoController
/*
 `shadowRadius`属性控制着阴影的*模糊度*，当它的值是0的时候，阴影就和视图一样有一个非常确定的边界线。
 当值越来越大的时候，边界线看上去就会越来越模糊和自然。
 
 `shadowOffset`属性控制着阴影的方向和距离。
 它是一个`CGSize`的值，宽度控制着阴影横向的位移，高度控制着纵向的位移。
 `shadowOffset`的默认值是 {0, -3}，意即阴影相对于Y轴有3个点的向上位移。
 
 `shadowPath`是一个`CGPathRef`类型（一个指向`CGPath`的指针）。`CGPath`是一个Core Graphics对象，用来指定任意的一个矢量图形。
 可以通过这个属性独立于图层形状之外指定阴影的形状。
 
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _layerView1 = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 150, 150)];
    UIImage *image = [UIImage imageNamed:@"Cone"];
    _layerView1.layer.contents = (__bridge id)image.CGImage;
    [self.view addSubview:self.layerView1];
    
    _layerView2 = [[UIView alloc] initWithFrame:CGRectMake(50, 300, 150, 150)];
    UIImage *img = [UIImage imageNamed:@"Cone"];
    _layerView2.layer.contents = (__bridge id)img.CGImage;
    [self.view addSubview:self.layerView2];
    
    //enable layer shadows
    self.layerView1.layer.shadowOpacity = 0.5f;
    self.layerView2.layer.shadowOpacity = 0.5f;
    
    // set shadow offset
    self.layerView1.layer.shadowOffset = CGSizeMake(0, 0);
    self.layerView2.layer.shadowOffset = CGSizeMake(20, 20);
    
    // square shadowPath
    CGMutablePathRef squarePath = CGPathCreateMutable();
    CGPathAddRect(squarePath, NULL, self.layerView1.bounds);
    self.layerView1.layer.shadowPath = squarePath;
    CGPathRelease(squarePath);
    
    // circle shadowPath
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddEllipseInRect(circlePath, NULL, self.layerView2.bounds);
    self.layerView2.layer.shadowPath = circlePath;
    CGPathRelease(circlePath);
}

@end
