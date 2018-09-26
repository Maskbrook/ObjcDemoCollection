//
//  InfiniteBannerViewItem.h
//  InfiniteBannerView
//
//  Created by jiabaozhang on 17/4/20.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InfiniteBannerViewItem : NSObject

@property (nonatomic, copy) NSURL *imageUrl;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) void(^handler)(InfiniteBannerViewItem *item);

+ (instancetype)itemWithImageUrl:(NSURL *)imageUrl title:(NSString *)title handelr:(void(^)(InfiniteBannerViewItem *item))handler;

@end
