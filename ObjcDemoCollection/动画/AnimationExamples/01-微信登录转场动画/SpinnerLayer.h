//
//  SpinnerLayer.h
//  ObjcDemoCollection
//
//  Created by 张家宝 on 2018/2/4.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface SpinnerLayer : CAShapeLayer

- (instancetype)initWithFrame:(CGRect)frame;
- (void)startSpinerAnimation;
- (void)stopSpinerAnimation;

@end
