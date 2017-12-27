//
//  NSTimer+Helper.h
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/27.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Helper)

+ (NSTimer *)hyd_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                          block:(void(^)(void))block
                                        repeats:(BOOL)repeats;

@end
