//
//  InfiniteBannerViewItem.m
//  InfiniteBannerView
//
//  Created by jiabaozhang on 17/4/20.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "InfiniteBannerViewItem.h"

@implementation InfiniteBannerViewItem

+ (instancetype)itemWithImageUrl:(NSURL *)imageUrl title:(NSString *)title handelr:(void (^)(InfiniteBannerViewItem *))handler
{
    InfiniteBannerViewItem *item = [[InfiniteBannerViewItem alloc] init];
    item.imageUrl = imageUrl;
    item.title = title;
    item.handler = handler ? handler : NULL;
    return item;
}


@end
