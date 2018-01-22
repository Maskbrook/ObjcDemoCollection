//
//  ImplicitAnimationDemo2Controller.h
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/1/22.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "BaseViewController.h"

@interface ImplicitAnimationDemo2Controller : BaseViewController

/*
 1、隐式动画如何实现？
    1）、我们把改变属性时CALayer自动应用的动画称作行为，当CALayer的属性被修改时候，它会调用-actionForKey:方法，传递属性的名称。
    2）、图层首先检测它是否有委托，并且是否实现CALayerDelegate协议指定的-actionForLayer:forKey方法。如果有，直接调用并返回结果。
    3）、如果没有委托，或者委托没有实现-actionForLayer:forKey方法，图层接着检查包含属性名称对应行为映射的actions字典。
    4）、如果actions字典没有包含对应的属性，那么图层接着在它的style字典接着搜索属性名。
    5）、最后，如果在style里面也找不到对应的行为，那么图层将会直接调用定义了每个属性的标准行为的-defaultActionForKey:方法。
所以一轮完整的搜索结束之后，-actionForKey:要么返回空（这种情况下将不会有动画发生），要么是CAAction协议对应的对象，最后CALayer拿这个结果去对先前和当前的值做动画。
 
 
 2、UIKit是如何禁用隐式动画的
 每个UIView对它关联的图层都扮演了一个委托，并且提供了-actionForLayer:forKey的实现方法。当不在一个动画块的实现中，UIView对所有图层行为返回nil，但是在动画block范围之内，它就返回了一个非空值。
 参见.m文件-(void)testImplictAnimation
 于是我们可以预言，当属性在动画块之外发生改变，UIView直接通过返回nil来禁用隐式动画。但如果在动画块范围之内，根据动画具体类型返回相应的属性，在这个例子就是CABasicAnimation
 
 
 UIView关联的图层禁用了隐式动画，对这种图层做动画的唯一办法就是使用UIView的动画函数（而不是依赖CATransaction），或者继承UIView，并覆盖-actionForLayer:forKey:方法，或者直接创建一个显式动画。
 对于单独存在的图层，我们可以通过实现图层的-actionForLayer:forKey:委托方法，或者提供一个actions字典来控制隐式动画。

 
 */

@end
