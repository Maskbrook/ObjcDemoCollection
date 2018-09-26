//
//  HYDRedPacketSegmentControl.h
//  HC-HYD
//
//  Created by jiabaozhang on 2018/6/22.
//  Copyright © 2018年 cheyy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectIndexBlock)(NSInteger index);


/// ********** HYDSegmentControlButton *********** ///
@interface HYDSegmentControlButton : UIButton
@end


/// ********** HYDRedPacketSegmentControl *********** ///
@interface HYDRedPacketSegmentControl : UIView
@property (nonatomic, assign) NSInteger selectedIndex;
/**
 默认选中index
 */
- (void)setDefaultSelectedIndex:(NSInteger)index;
/**
 选中的操作
 */
- (void)setSelectIndexActionBlock:(SelectIndexBlock)aIndexActionBlock;
/**
 初始化函数
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

@end
