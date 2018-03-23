//
//  KVO_Observer.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/20.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "KVO_Observer.h"

@interface KVO_Observer ()

@property (nonatomic, weak) id target;
@property (nonatomic) SEL selector;
@property (nonatomic, weak) id observeredObject;
@property (nonatomic, copy) NSString *keyPath;

@end

@implementation KVO_Observer

- (instancetype)initWithObject:(id)object keyPath:(NSString *)keyPath target:(id)target selector:(SEL)selector
{
    if (self = [super init]) {
        self.target = target;
        self.selector = selector;
        self.observeredObject = object;
        self.keyPath = keyPath;
// 预处理指令 屏蔽警告
// 更多预处理指令，参考：http://fuckingclangwarnings.com/
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
        [object addObserver:self forKeyPath:keyPath options:0 context:(__bridge void * _Nullable)(self)];
#pragma clang diagnostic pop
    }
    return self;
}

+ (instancetype)observerWithObject:(id)object keyPath:(NSString *)keyPath target:(id)target selector:(SEL)selector
{
    return [[self alloc] initWithObject:object keyPath:keyPath target:target selector:selector];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == (__bridge void * _Nullable)(self)) {
        id strongTarget = self.target;
        if ([strongTarget respondsToSelector:self.selector]) {
// 屏蔽警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [strongTarget performSelector:self.selector];
#pragma clang diagnostic pop
        }
    }
}

- (void)dealloc
{
    id strongObservedObject = self.observeredObject;
    if (strongObservedObject) {
        [strongObservedObject removeObserver:self forKeyPath:self.keyPath];
    }
}

@end
