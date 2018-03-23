//
//  SpinnerTransition.h
//  ObjcDemoCollection
//
//  Created by 张家宝 on 2018/2/4.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpinnerTransition : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTransitionDuration:(NSTimeInterval)transitionDuration StartingAlpha:(CGFloat)startingAlpha isBOOL:(BOOL)is;

@end
