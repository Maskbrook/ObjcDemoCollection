//
//  CommonFuctions.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/5/17.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "CommonFuctions.h"

@implementation CommonFuctions

//金额输入框，将纯数字格式化为千分位，添加逗号分隔
- (NSString *)getThreeBitFormatStringFromNumerString:(NSString *)aNumberString
{
    if (aNumberString.length <= 0) {
        return @"".mutableCopy;
    }
    
    NSString *tempRemoveD = [aNumberString stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSMutableString *stringM = [NSMutableString stringWithString:tempRemoveD];
    NSInteger n = 2;
    for (NSInteger i = tempRemoveD.length - 3; i > 0; i--) {
        n++;
        if (n == 3) {
            [stringM insertString:@"," atIndex:i];
            n = 0;
        }
    }
    
    return stringM;
}

//将格式化为千分位的字符串转为纯数字
- (NSString *)getNumberStringFromThreeBitFormatString:(NSString *)aThreeBitFromatString
{
    if (aThreeBitFromatString.length <= 0) {
        return @"".mutableCopy;
    }
    NSString *tempRemoveD = [aThreeBitFromatString stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSMutableString *stringM = [NSMutableString stringWithString:tempRemoveD];
    
    return stringM;
}

// 根据传入的图片名，实现tintImage
- (UIImage *)tintImageWithImageName:(NSString *)imageName tintColor:(UIColor *)tintColor
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
