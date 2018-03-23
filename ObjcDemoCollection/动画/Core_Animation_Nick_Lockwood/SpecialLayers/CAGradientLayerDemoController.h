//
//  CAGradientLayerDemoController.h
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/1/16.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "BaseViewController.h"

@interface CAGradientLayerDemoController : BaseViewController

/*
 CAGradientLayer:
 
 用途：生成两种或更多颜色平滑渐变
 
 优势：使用硬件加速
 
 步骤：
    Step 1：创建gradientLayer并且添加到对应view的sublayer上
    Step 2：设置颜色数组
    Step 3：设置起点与终点(左上角（0，0），右下角（1，1）)
 
 常用属性
    colors:颜色值数组
    startPoint：渐变开始的点
    endPoint：渐变结束的点
    locations:一个浮点数值的数组（以NSNumber包装）。这些浮点数定义了colors属性中每个不同颜色的位置，同样的，也是以单位坐标系进行标定。0.0代表着渐变的开始，1.0代表着结束。
    locations数组并不是强制要求的，但是如果你给它赋值了就一定要确保locations的数组大小和colors数组大小一定要相同，否则你将会得到一个空白的渐变。
 */

@end
