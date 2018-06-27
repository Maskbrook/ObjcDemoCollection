//
//  NSString+Helper.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/5/21.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)

//金额输入框，将纯数字格式化为千分位，添加逗号分隔
+ (NSString *)getThreeBitFormatStringFromNumerString:(NSString *)aNumberString
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
+ (NSString *)getNumberStringFromThreeBitFormatString:(NSString *)aThreeBitFromatString
{
    if (aThreeBitFromatString.length <= 0) {
        return @"".mutableCopy;
    }
    NSString *tempRemoveD = [aThreeBitFromatString stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSMutableString *stringM = [NSMutableString stringWithString:tempRemoveD];
    
    return stringM;
}

@end
