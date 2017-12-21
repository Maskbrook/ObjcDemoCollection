//
//  NSObject+KVO_Block.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/20.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "NSObject+KVO_Block.h"
#import <objc/runtime.h>
#import <objc/message.h>

NSString *const kHCKVOClassPrefix = @"HCKVOClassPrefix_";
NSString *const kHCKVOAssociatedObservers = @"HCKVOAssociatedObservers";

// ************* HCObservationInfo ************** //
@interface HCObservationInfo : NSObject

@property (nonatomic, weak) NSObject *observer;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) HCObservingBlock block;

@end

@implementation HCObservationInfo

- (instancetype)initWithObserver:(NSObject *)observer Key:(NSString *)key block:(HCObservingBlock)block
{
    self = [super init];
    if (self) {
        _observer = observer;
        _key = key;
        _block = block;
    }
    return self;
}

@end


// ************* NSObject (KVO_Block) ************** //
@implementation NSObject (KVO_Block)

- (void)HC_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath handleBlock:(HCObservingBlock)block
{
    // 1. 检查对象的类 有没有相应setter方法，若无则抛出异常
    SEL setterSelector = NSSelectorFromString([self setterForGetter:keyPath]);
    Method setterMethod = class_getInstanceMethod([self class], setterSelector);
    if (!setterMethod) {
        return;
    }
    
    // 2. 检查对象isa指针指向的类是不是一个KVO类。
    // 如果不是，新建一个继承原来类的子类，并把isa指向这个新建的子类
    Class clazz = object_getClass(self);
    NSString *clazzName = NSStringFromClass(clazz);
    if (![clazzName hasPrefix:kHCKVOClassPrefix]) {
        clazz = [self HC_KVOClassWithOriginalClassName:clazzName];
        object_setClass(self, clazz);
    }
    
    // 3. 为kvo class添加setter方法的实现
    const char *types = method_getTypeEncoding(setterMethod);
    class_addMethod(clazz, setterSelector, (IMP)kvo_setter, types);
    
    // 4. 添加该观察者到观察者列表中
    HCObservationInfo *info = [[HCObservationInfo alloc] initWithObserver:observer Key:keyPath block:block];
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)(kHCKVOAssociatedObservers));
    if (!observers) {
        observers = [NSMutableArray array];
        objc_setAssociatedObject(self, (__bridge const void *)(kHCKVOAssociatedObservers), observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [observers addObject:info];
}

- (void)HC_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath
{
    NSMutableArray* observers = objc_getAssociatedObject(self, (__bridge const void *)(kHCKVOAssociatedObservers));
    
    HCObservationInfo *infoToRemove;
    for (HCObservationInfo* info in observers) {
        if (info.observer == observer && [info.key isEqual:keyPath]) {
            infoToRemove = info;
            break;
        }
    }
    
    [observers removeObject:infoToRemove];
}

#pragma mark - private methods

- (Class)HC_KVOClassWithOriginalClassName:(NSString *)className
{
    NSString *kvoClassName = [kHCKVOClassPrefix stringByAppendingString:className];
    Class kvoClass = NSClassFromString(kvoClassName);
    
    // 如果kvo class存在则返回
    if (kvoClass) {
        return kvoClass;
    }
    
    // 如果kvo class不存在, 则创建这个类
    Class originClass = object_getClass(self);
    kvoClass = objc_allocateClassPair(originClass, kvoClassName.UTF8String, 0);
    // 修改kvo class方法的实现
    Method classMethod = class_getInstanceMethod(kvoClass, @selector(class));
    const char *types = method_getTypeEncoding(classMethod);
    class_addMethod(kvoClass, @selector(class), (IMP)kvo_class, types);
    
    return kvoClass;
}

/**
 模仿Apple的做法, 欺骗人们这个kvo类还是原类
 */
static Class kvo_class(id self, SEL cmd)
{
    Class clazz = object_getClass(self);
    Class superClazz = class_getSuperclass(clazz);
    return superClazz;
}


/**
 重写setter方法, 新方法在调用原方法后, 通知每个观察者(调用传入的block)
 */
static void kvo_setter(id self, SEL _cmd, id newValue)
{
    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *getterName = [self getterForSetter:setterName];
    
    if (!getterName) {
        return;
    }
    
    // 获取旧值
    id oldValue = [self valueForKey:getterName];

    struct objc_super superClazz = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    // cast our pointer so the compiler won't complain
    void (*objc_msgSendSuperCasted)(void *, SEL, id) = (void *)objc_msgSendSuper;
    // call super's setter, which is original class's setter method
    objc_msgSendSuperCasted(&superClazz, _cmd, newValue);
    
    // look up observers and call the blocks
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)(kHCKVOAssociatedObservers));
    for (HCObservationInfo *each in observers) {
        if ([each.key isEqualToString:getterName]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                each.block(self, getterName, oldValue, newValue);
            });
        }
    }
}


/**
 根据getter方法获取setter方法
 */
- (NSString *)setterForGetter:(NSString *)key
{
    // key -> Key -> setKey
    unichar c = [key characterAtIndex:0];
    NSString *str = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[NSString stringWithFormat:@"%c", c-32]];
    NSString *setter = [NSString stringWithFormat:@"set%@", str];
    return setter;
}

/**
 *  根据setter方法名返回getter方法名
 */
- (NSString *)getterForSetter:(NSString *)key
{
    // setKey: -> Key -> key
    // 去掉set
    NSRange range = [key rangeOfString:@"set"];
    NSString *subStr1 = [key substringFromIndex:range.location + range.length];
    // 首字母转换成大写
    unichar c = [subStr1 characterAtIndex:0];
    NSString *subStr2 = [subStr1 stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[NSString stringWithFormat:@"%c", c+32]];
    // 去掉最后的:
    NSRange range2 = [subStr2 rangeOfString:@":"];
    NSString *getter = [subStr2 substringToIndex:range2.location];
    
    return getter;
}

@end
