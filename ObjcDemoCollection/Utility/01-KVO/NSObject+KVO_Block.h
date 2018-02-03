//
//  NSObject+KVO_Block.h
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/20.
//  Copyright © 2017年 jiabaozhang. All rights reserved.

//  通过block方式实现KVO

#import <Foundation/Foundation.h>

typedef void(^HCObservingBlock)(id observedObject, NSString *observedKeyPath, id oldValue, id newValue);

@interface NSObject (KVO_Block)

- (void)HC_addObserver:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
           handleBlock:(HCObservingBlock)block;

- (void)HC_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

@end
