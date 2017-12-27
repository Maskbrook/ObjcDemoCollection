//
//  MaskLayerDemoController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/27.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "MaskLayerDemoController.h"

@interface MaskLayerDemoController ()

@property (nonatomic, strong) UIImageView *iglooView;

@end

@implementation MaskLayerDemoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // imageView
    self.iglooView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Igloo"]];
    self.iglooView.frame = CGRectMake(0, 0, 200, 200);
    self.iglooView.center = self.view.center;
    [self.view addSubview:self.iglooView];
    
    // create mask layer
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.iglooView.bounds;
    UIImage *maskImage = [UIImage imageNamed:@"Cone.png"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    
    // apply mask to image
    // 把iglooView的图片裁剪成maskLayer的形状
    // 如果`mask`图层比父图层要小，只有在`mask`图层里面的内容才是它关心的，除此以外的一切都会被隐藏起来。
    self.iglooView.layer.mask = maskLayer;
}
@end
