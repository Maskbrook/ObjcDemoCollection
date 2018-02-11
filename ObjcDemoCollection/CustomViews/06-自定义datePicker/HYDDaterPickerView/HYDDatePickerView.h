//
//  HYDDatePickerView.h
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/2/11.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYDDatePickerView : UIView

@property (nonatomic, copy) void(^HYDDatePickerViewConfimrBlock)(UIButton *sender);

+ (instancetype)datePickerView;

@end
