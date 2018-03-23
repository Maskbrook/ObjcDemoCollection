//
//  CoreAnimationBasicController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/26.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "CoreAnimationBasicController.h"
#import "ContentsDemoController.h"
#import "GeometryDemoController.h"
#import "ContainsPointDemoController.h"
#import "ShadowDemoController.h"
#import "MaskLayerDemoController.h"
#import "StretchFilterDemoController.h"
#import "TransformDemoController.h"
#import "Transform3DDemoController.h"
// 专用图层
#import "CAShapeLayerDemoController.h"
#import "CATextLayerDemoController.h"
#import "CATransformLayerDemoController.h"
#import "CAGradientLayerDemoController.h"
#import "CAReplicatorLayerDemoController.h"
#import "CAScrollLayerDemoController.h"
#import "CAEmitterLayerDemoController.h"
#import "CAEAGLLayerDemoController.h"
#import "AVPalyerLayerDemoController.h"
// 隐式动画
#import "ImplicitAnimationDemoController.h"
#import "ImplicitAnimationDemo2Controller.h"
#import "ImplicitAnimationDemo3Controller.h"
// 显示动画
#import "ExplicitAnimationDemoController.h"
#import "BaseTableViewCell.h"

@interface CoreAnimationBasicController ()

@end

@implementation CoreAnimationBasicController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.items = @[
                   
                   @{@"title" : @"内容拼接", @"controller" : [ContentsDemoController new]},
                   @{@"title" : @"锚点与简单时钟动画", @"controller" : [GeometryDemoController new]},
                   @{@"title" : @"containsPoint, hitTest", @"controller" : [ContainsPointDemoController new]},
                   @{@"title" : @"自定义阴影", @"controller" : [ShadowDemoController new]},
                   @{@"title" : @"图层蒙板", @"controller" : [MaskLayerDemoController new]},
                   @{@"title" : @"拉伸过滤与数字时钟", @"controller" : [StretchFilterDemoController new]},
                   @{@"title" : @"CGAffineTransform操作", @"controller" : [TransformDemoController new]},
                   @{@"title" : @"Transform3D操作", @"controller" : [Transform3DDemoController new]},
                   @{@"title" : @"专用图层:CAShapeLayer", @"controller" : [CAShapeLayerDemoController new]},
                   @{@"title" : @"专用图层:CATextLayer", @"controller" : [CATextLayerDemoController new]},
                   @{@"title" : @"专用图层:CATransformLayer", @"controller" : [CATransformLayerDemoController new]},
                   @{@"title" : @"专用图层:CAGradientLayer(渐变)", @"controller" : [CAGradientLayerDemoController new]},
                   @{@"title" : @"专用图层:CAReplicatorLayer(相似图层)", @"controller" : [CAReplicatorLayerDemoController new]},
                   @{@"title" : @"专用图层:CAScrollLayer(滚动)", @"controller" : [CAScrollLayerDemoController new]},
                   @{@"title" : @"专用图层:CAEmitterLayer(粒子,如烟雾、火)", @"controller" : [CAEmitterLayerDemoController new]},
                   @{@"title" : @"专用图层:CAEAGLLayer(OpenGL)", @"controller" : [CAEAGLLayerDemoController new]},
                   @{@"title" : @"专用图层:AVPalyerLayer(播放器图层)", @"controller" : [AVPalyerLayerDemoController new]},
                   @{@"title" : @"隐式动画-1", @"controller" : [ImplicitAnimationDemoController new]},
                   @{@"title" : @"隐式动画-2", @"controller" : [ImplicitAnimationDemo2Controller new]},
                   @{@"title" : @"隐式动画-3", @"controller" : [ImplicitAnimationDemo3Controller new]},
                   @{@"title" : @"显示动画-1", @"controller" : [ExplicitAnimationDemoController new]},
                   
                   ].mutableCopy;
}

#pragma mark ## tableView methods ##
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableViewCell *cell = [BaseTableViewCell cellWithTableView:tableView];
    cell.nameLabel.text = [[self.items objectAtIndex:indexPath.row] valueForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushViewControllerWithIndexPath:indexPath];
}

@end
