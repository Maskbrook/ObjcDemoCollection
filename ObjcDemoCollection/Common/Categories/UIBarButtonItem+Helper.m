//
//  UIBarButtonItem+Helper.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/5/21.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "UIBarButtonItem+Helper.h"
#import "UIImage+Helper.h"


@implementation UIBarButtonItem (Helper)

+ (UIBarButtonItem *)itemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    
    UIImage *normalImage = [UIImage tintImageWithImageName:image tintColor:[UIColor whiteColor]];
    UIImage *highImage = [UIImage tintImageWithImageName:highlightImage tintColor:[UIColor lightGrayColor]];
    
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    [button setBackgroundImage:highImage forState:UIControlStateHighlighted];
    
    button.frame = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    button.backgroundColor = [UIColor redColor];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
