//
//  ShopData.m
//  ObjcDemoCollection
//
//  Created by 张家宝 on 2018/2/4.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "ShopData.h"
#import <objc/runtime.h>

@implementation ShopData

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.w = [dict[@"w"] floatValue];
        self.h = [dict[@"h"] floatValue];
        self.img = dict[@"img"];
        self.price = dict[@"price"];
    }
    return self;
}

+ (instancetype)shopWithDict:(NSDictionary *)dict
{
    id shop = [[self alloc] init];
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        ivarName = [ivarName substringFromIndex:1];
        id value = dict[ivarName];
        [shop setValue:value forKeyPath:ivarName];
    }
    free(ivars);
    return shop;
}

@end
