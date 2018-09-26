//
//  RedPacketModel.h
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/6/27.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RedPacketModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *detail;
- (instancetype)initWithName:(NSString *)name detail:(NSString *)detail;
@end
