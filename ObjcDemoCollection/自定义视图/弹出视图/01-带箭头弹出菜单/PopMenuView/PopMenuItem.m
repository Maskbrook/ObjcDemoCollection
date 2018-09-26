//
//  PopMenuItem.m
//  CustomPopMenuView
//
//  Created by jiabaozhang on 17/4/10.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "PopMenuItem.h"

@implementation PopMenuItem

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image handler:(void (^)(PopMenuItem *))handler
{
    PopMenuItem *item = [[PopMenuItem alloc] init];
    item.title = title;
    item.image = image;
    item.handler = handler ? handler : NULL;
    
    return item;
}

@end
