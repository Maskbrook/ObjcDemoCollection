//
//  WaterflowShopData.m
//  ObjectiveCSummmaryDemo
//
//  Created by jiabaozhang on 2017/5/6.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "WaterflowShopData.h"

@implementation WaterflowShopData

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

@end
