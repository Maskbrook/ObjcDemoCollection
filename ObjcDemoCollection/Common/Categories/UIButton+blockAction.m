//
//  UIButton+blockAction.m
//  ObjectiveCSummmaryDemo
//
//  Created by jiabaozhang on 17/5/5.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "UIButton+blockAction.h"
#import <objc/runtime.h>

static char const *actionBlockKey = "actionBlockKey";
static char const *nameKey = "nameKey";

@implementation UIButton (blockAction)

- (void)setActionBlock:(ButtonActionBlock)actionBlock
{
    objc_setAssociatedObject(self, &actionBlockKey, actionBlock, OBJC_ASSOCIATION_COPY);
    
    if (actionBlock) {
        [self addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (ButtonActionBlock)actionBlock
{
    return objc_getAssociatedObject(self, &actionBlockKey);
}

- (void)btnClick
{
    if (self.actionBlock) {
        self.actionBlock();
    }
}

- (void)setName:(NSString *)name
{
    // 把属性关联给对象
    objc_setAssociatedObject(self, &nameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name
{
    // 取出属性
    return objc_getAssociatedObject(self, &nameKey);
}

@end
