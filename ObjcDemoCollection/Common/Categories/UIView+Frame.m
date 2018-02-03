//
//  UIView+Frame.m
//  PPScrollingTagsDemo
//
//  Created by jiabaozhang on 17/5/15.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)pp_x
{
    return self.frame.origin.x;
}

- (void)setPp_x:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)pp_y
{
    return self.frame.origin.y;
}

- (void)setPp_y:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)pp_width
{
    return self.frame.size.width;
}

- (void)setPp_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)pp_height
{
    return self.frame.size.height;
}

- (void)setPp_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)pp_centerX
{
    return self.center.x;
}

- (void)setPp_centerX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)pp_centerY
{
    return self.center.y;
}

- (void)setPp_centerY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGSize)pp_size {
    return self.frame.size;
}

- (void)setPp_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)pp_top {
    return self.frame.origin.y;
}

- (void)setPp_top:(CGFloat)t {
    self.frame = CGRectMake(self.pp_left, t, self.pp_width, self.pp_height);
}

- (CGFloat)pp_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setPp_bottom:(CGFloat)b {
    self.frame = CGRectMake(self.pp_left, b - self.pp_height, self.pp_width, self.pp_height);
}

- (CGFloat)pp_left {
    return self.frame.origin.x;
}

- (void)setPp_left:(CGFloat)l {
    self.frame = CGRectMake(l, self.pp_top, self.pp_width, self.pp_height);
}

- (CGFloat)pp_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setPp_right:(CGFloat)r {
    self.frame = CGRectMake(r - self.pp_width, self.pp_top, self.pp_width, self.pp_height);
}


@end
