//
//  KVO_Observer.h
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/20.
//  Copyright © 2017年 jiabaozhang. All rights reserved.

//  自定义KVO观察者

#import <Foundation/Foundation.h>

@interface KVO_Observer : NSObject

/**
 初始化观察者
 @param object 待观察对象
 @param keyPath 待观察属性
 @param target 观察者，一般为self
 @param selector 待观察属性变化后，执行的方法
 */
- (instancetype)initWithObject:(id)object
                       keyPath:(NSString *)keyPath
                        target:(id)target
                      selector:(SEL)selector;

/**
 初始化观察者
 @param object 待观察对象
 @param keyPath 待观察属性
 @param target 观察者，一般为self
 @param selector 待观察属性变化后，执行的方法
 */
+ (instancetype)observerWithObject:(id)object
                           keyPath:(NSString *)keyPath
                            target:(id)target
                          selector:(SEL)selector;

@end
