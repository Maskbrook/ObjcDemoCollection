//
//  ContentsDemoController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/26.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "ContentsDemoController.h"

@interface ContentsDemoController ()

@property (nonatomic, strong) UIView *coneView;
@property (nonatomic, strong) UIView *shipView;
@property (nonatomic, strong) UIView *iglooView;
@property (nonatomic, strong) UIView *anchorView;

@end

@implementation ContentsDemoController

/*
 // contentsScale`属性其实属于支持高分辨率（又称Hi-DPI或Retina）屏幕机制的一部分。
 // 如果`contentsScale`设置为1.0，将会以每个点1个像素绘制图片，如果设置为2.0，则会以每个点2个像素绘制图片
 
 // 和`bounds`，`frame`不同，`contentsRect`不是按点来计算的，它使用了*单位坐标*
 // 默认的`contentsRect`是{0, 0, 1, 1}，这意味着整个寄宿图默认都是可见的，如果我们指定一个小一点的矩形，图片就会被裁剪
 
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.coneView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, 128, 128)];
    self.coneView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.coneView];
    self.shipView = [[UIView alloc] initWithFrame:CGRectMake(150, 80, 128, 128)];
    self.shipView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.shipView];
    self.anchorView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 128, 128)];
    self.anchorView.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:self.anchorView];
    self.iglooView = [[UIView alloc] initWithFrame:CGRectMake(150, 200, 128, 128)];
    self.iglooView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.iglooView];
    UIImage *image = [UIImage imageNamed:@"Sprites.png"];
    //set igloo sprite 只显示图片左上角四分之一部分
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0, 0.5, 0.5) toLayer:self.iglooView.layer];
    //set cone sprite 只显示图片右上角四分之一部分
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0, 0.5, 0.5) toLayer:self.coneView.layer];
    //set anchor sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0.5, 0.5, 0.5) toLayer:self.anchorView.layer];
    //set spaceship sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0.5, 0.5, 0.5) toLayer:self.shipView.layer];
}

- (void)addSpriteImage:(UIImage *)image withContentRect:(CGRect)rect toLayer:(CALayer *)layer
{
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsGravity = kCAGravityResizeAspect;
    layer.contentsRect = rect;
}

@end
