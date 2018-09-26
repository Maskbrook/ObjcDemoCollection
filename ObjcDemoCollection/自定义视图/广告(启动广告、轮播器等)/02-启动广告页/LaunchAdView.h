//
//  LaunchAdView.h
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/3/27.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LaunchType) {
    LaunchTypeCircle,
    LaunchTypeCountButton
};

@interface LaunchAdView : UIView

//计时时间
@property (nonatomic, assign) NSTimeInterval duration;

//样式
@property (nonatomic, assign) LaunchType type;

- (void)dismiss;

@end
