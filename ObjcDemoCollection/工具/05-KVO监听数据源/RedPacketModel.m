//
//  RedPacketModel.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/6/27.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "RedPacketModel.h"

@implementation RedPacketModel

- (instancetype)initWithName:(NSString *)name detail:(NSString *)detail
{
    if (self = [super init]) {
        _name = name;
        _detail = detail;
    }
    return self;
}

@end
