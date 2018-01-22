//
//  ImplicitAnimationDemoController.h
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/1/22.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "BaseViewController.h"

@interface ImplicitAnimationDemoController : BaseViewController

/*
 隐式动画
 
 1、为什么叫隐式动画？
    隐式动画之所以叫隐式是因为我们并没有指定任何动画的类型。我们仅仅改变了一个属性，然后Core Animation来决定如何并且何时去做动画。
 
 2、改变一个属性，Core Animation如何判断动画类型和持续时间？
    实际上动画执行的时间取决于当前事务（CATransaction）的设置，动画类型取决于图层行为。
 
 3、关于事务
    CATransaction没有属性或者实例方法，并且也不能用+alloc和-init方法创建它。但是可以用+begin和+commit分别来入栈或者出栈。
 
 Core Animation在每个run loop周期中自动开始一次新的事务（run loop是iOS负责收集用户输入，处理定时器或者网络事件并且重新绘制屏幕的东西），即使你不显式的用[CATransaction begin]开始一次事务，任何在一次run loop循环中属性的改变都会被集中起来，然后做一次0.25秒的动画
 */

@end
