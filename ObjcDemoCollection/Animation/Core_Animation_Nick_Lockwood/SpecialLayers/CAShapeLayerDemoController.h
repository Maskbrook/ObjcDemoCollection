//
//  CAShapeLayerDemoController.h
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/1/15.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "BaseViewController.h"

@interface CAShapeLayerDemoController : BaseViewController

/*
 
 CAShapeLayer是一个通过矢量图形而不是bitmap来绘制的图层子类。
 
 当然也可以用Core Graphics直接向原始的CALyer的内容中绘制一个路径，相比直下，使用CAShapeLayer有以下一些优点：
 (1)渲染快速。CAShapeLayer使用了硬件加速，绘制同一图形会比用Core Graphics快很多。
 (2)高效使用内存。一个CAShapeLayer不需要像普通CALayer一样创建一个寄宿图形，所以无论有多大，都不会占用太多的内存。
 (3)不会被图层边界剪裁掉。一个CAShapeLayer可以在边界之外绘制。你的图层路径不会像在使用Core Graphics的普通CALayer一样被剪裁掉。
 (4)不会出现像素化。当你给CAShapeLayer做3D变换时，它不像一个有寄宿图的普通图层一样变得像素化。

 
 */

@end
