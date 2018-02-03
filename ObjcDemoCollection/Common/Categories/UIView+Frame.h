//
//  UIView+Frame.h
//  PPScrollingTagsDemo
//
//  Created by jiabaozhang on 17/5/15.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat pp_x;
@property (nonatomic, assign) CGFloat pp_y;
@property (nonatomic, assign) CGFloat pp_width;
@property (nonatomic, assign) CGFloat pp_height;
@property (nonatomic, assign) CGFloat pp_centerX;
@property (nonatomic, assign) CGFloat pp_centerY;

@property (nonatomic, assign) CGSize pp_size;
@property (nonatomic, assign) CGFloat pp_top;
@property (nonatomic, assign) CGFloat pp_bottom;
@property (nonatomic, assign) CGFloat pp_left;
@property (nonatomic, assign) CGFloat pp_right;

@end
