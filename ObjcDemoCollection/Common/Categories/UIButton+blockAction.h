//
//  UIButton+blockAction.h
//  ObjectiveCSummmaryDemo
//
//  Created by jiabaozhang on 17/5/5.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonActionBlock)();

@interface UIButton (blockAction)

@property (nonatomic, copy) ButtonActionBlock actionBlock;

// @property 在分类中只会生成 getter/setter 方法
// 不会生成成员属性
@property NSString *name;

@end
