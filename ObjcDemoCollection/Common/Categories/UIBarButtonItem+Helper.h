//
//  UIBarButtonItem+Helper.h
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/5/21.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Helper)

+ (UIBarButtonItem *)itemWithImage:(NSString *)image
                    highlightImage:(NSString *)highlightImage
                            target:(id)target
                            action:(SEL)action;

@end
