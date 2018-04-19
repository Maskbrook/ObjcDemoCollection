//
//  UIView+GetController.h
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/4/17.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GetController)

//获取某个view所属的控制器
- (UIViewController *)findViewController;

@end
