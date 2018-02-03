//
//  PopMenuItem.h
//  CustomPopMenuView
//
//  Created by jiabaozhang on 17/4/10.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PopMenuItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) void(^handler)(PopMenuItem *item);

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image handler:(void(^)(PopMenuItem *item))handler;

@end
