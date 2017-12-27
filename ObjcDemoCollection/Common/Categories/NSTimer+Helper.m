//
//  NSTimer+Helper.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/27.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "NSTimer+Helper.h"

@implementation NSTimer (Helper)

+ (NSTimer *)hyd_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void (^)(void))block repeats:(BOOL)repeats
{
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(hyd_blockInvoke:) userInfo:[block copy] repeats:YES];
}

+ (void)hyd_blockInvoke:(NSTimer *)timer
{
    void (^block)(void) = timer.userInfo;
    
    if (block) {
        block();
    }
}

@end
