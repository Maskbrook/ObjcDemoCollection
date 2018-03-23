//
//  ScrollingBarItem.m
//  ObjectiveCSummmaryDemo
//
//  Created by jiabaozhang on 17/5/17.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "ScrollingBarItem.h"

@implementation ScrollingBarItem

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

@end
