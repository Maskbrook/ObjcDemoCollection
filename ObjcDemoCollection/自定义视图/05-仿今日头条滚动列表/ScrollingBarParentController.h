//
//  ScrollingBarParentController.h
//  ObjectiveCSummmaryDemo
//
//  Created by jiabaozhang on 17/5/17.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollingBarParentController : UIViewController

/**
 *  设置总体frame
 *  包括标题和内容
 *  required
 */
@property (nonatomic, copy) void(^SetContentFrameBlock)(UIView *contentView);

/**
 *  选中label的缩放比例
 *  最好控制在 0.0~0.2
 */
@property (nonatomic, assign) CGFloat scale;

/**
 *  是否显示coverView
 *
 */
@property (nonatomic, assign) BOOL displayCoverView;

/**
 *  是否显示underlineView
 *
 */
@property (nonatomic, assign) BOOL displayUnderlineView;

@end
