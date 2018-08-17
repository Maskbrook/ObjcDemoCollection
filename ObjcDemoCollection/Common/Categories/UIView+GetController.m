//
//  UIView+GetController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/4/17.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "UIView+GetController.h"

@implementation UIView (GetController)

- (UIViewController *)findViewController
{
//    id responder = self;
//    while (responder){
//        if ([responder isKindOfClass:[UIViewController class]]) {
//            return responder;
//        }
//        responder = [responder nextResponder];
//    }
//    return nil;
    
    for (id next = self; next; next = [next nextResponder]) {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
    }
    return nil;
}

@end
