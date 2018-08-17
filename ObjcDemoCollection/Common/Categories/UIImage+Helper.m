//
//  UIImage+Helper.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/5/21.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "UIImage+Helper.h"

@implementation UIImage (Helper)

// 根据传入的图片名，实现tintImage
+ (UIImage *)tintImageWithImageName:(NSString *)imageName tintColor:(UIColor *)tintColor
{
    UIImage *originalImage = [UIImage imageNamed:imageName];
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, originalImage.size.width, originalImage.size.height);
    UIRectFill(bounds);
    [originalImage drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    UIImage *tintImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tintImage;
}

@end
