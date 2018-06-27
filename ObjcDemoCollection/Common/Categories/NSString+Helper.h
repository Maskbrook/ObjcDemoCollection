//
//  NSString+Helper.h
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/5/21.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)

//金额输入框，将纯数字格式化为千分位，添加逗号分隔
+ (NSString *)getThreeBitFormatStringFromNumerString:(NSString *)aNumberString;

//将格式化为千分位的字符串转为纯数字
+ (NSString *)getNumberStringFromThreeBitFormatString:(NSString *)aThreeBitFromatString;


@end
