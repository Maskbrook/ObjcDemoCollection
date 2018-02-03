//
//  AppstoreInfo.m
//  ObjectiveCSummmaryDemo
//
//  Created by jiabaozhang on 17/5/8.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "AppstoreInfo.h"
#import <objc/runtime.h>

@implementation AppstoreInfo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

// 打印所有属性值
- (NSString *)description
{
    NSString *desc = @"\n";
    
    unsigned int outCount;
    // 获取obj的属性数目
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        // 获取property的C字符串
        const char *propName = property_getName(property);
        if (propName) {
            // 获取NSString类型的property名字
            NSString *prop = [NSString stringWithCString:propName encoding:[NSString defaultCStringEncoding]];
            // 获取property对应的值
            id obj = [self valueForKey:prop];
            // 将属性名和属性值拼接起来
            desc = [desc stringByAppendingFormat:@"%@ : %@;\n", prop, obj];
        }
    }
    
    free(properties);
    NSLog(@"%@",desc);
    return desc;
}

@end
