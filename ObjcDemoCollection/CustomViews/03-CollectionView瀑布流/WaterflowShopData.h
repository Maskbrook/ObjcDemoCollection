//
//  WaterflowShopData.h
//  ObjectiveCSummmaryDemo
//
//  Created by jiabaozhang on 2017/5/6.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterflowShopData : NSObject

@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *price;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
