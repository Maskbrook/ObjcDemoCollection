//
//  ContainsPointDemoController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/27.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "ContainsPointDemoController.h"

@interface ContainsPointDemoController ()

@property (nonatomic, strong) UIView *redLayerView;
@property (nonatomic, strong) CALayer *blueLayer;

@end

@implementation ContainsPointDemoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutPageSubviews];
}

#pragma mark - touch event
/*
 *  -containsPoint: `接受一个在 本图层 坐标系下的`CGPoint`，如果这个点在图层`frame`范围内就返回`YES
 *  -hitTest:`方法同样接受一个`CGPoint`类型参数，而不是`BOOL`类型，它返回图层本身，或者包含这个坐标点的叶子节点图层。
 *  这意味着不再需要像使用`-containsPoint:`那样，人工地在每个子图层变换或者测试点击的坐标。如果这个点在最外面图层的范围之外，则返回nil。
 */

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    /*
    CGPoint point = [[touches anyObject] locationInView:self.view];
    // convert point to the red layer's coordinates
    point = [self.redLayerView.layer convertPoint:point fromLayer:self.view.layer];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    if ([self.redLayerView.layer containsPoint:point]) {
        //convert point to blue Layer’s coordinates
        point = [self.blueLayer convertPoint:point fromLayer:self.redLayerView.layer];
        if ([self.blueLayer containsPoint:point]) {
            [[[UIAlertView alloc] initWithTitle:@"Inside Blue Layer"
                                        message:nil
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
            
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Inside Red View"
                                        message:nil
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Inside main View"
                                    message:nil
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
#pragma clang diagnostic pop
     */
    
    CGPoint point = [[touches anyObject] locationInView:self.view];
    CALayer *layer = [self.view.layer hitTest:point];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    if (layer == self.blueLayer) {
        [[[UIAlertView alloc] initWithTitle:@"Inside Blue Layer"
                                    message:nil
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    } else if (layer == self.redLayerView.layer) {
        [[[UIAlertView alloc] initWithTitle:@"Inside Red View"
                                    message:nil
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Inside Main View"
                                    message:nil
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
#pragma clang diagnostic pop
}

#pragma mark - Private Methods
- (void)layoutPageSubviews
{
    [self.view addSubview:self.redLayerView];
    self.redLayerView.frame = CGRectMake(0, 0, 260, 260);
    self.redLayerView.center = self.view.center;
    
    [self.redLayerView.layer addSublayer:self.blueLayer];
    self.blueLayer.frame = CGRectMake(-40, -30, 150, 150);
}

#pragma mark - getters
- (UIView *)redLayerView
{
    if (_redLayerView == nil) {
        _redLayerView = [[UIView alloc] init];
        _redLayerView.backgroundColor = [UIColor redColor];
    }
    return _redLayerView;
}

- (CALayer *)blueLayer
{
    if (_blueLayer == nil) {
        _blueLayer = [CALayer layer];
        _blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    }
    return _blueLayer;
}

@end
