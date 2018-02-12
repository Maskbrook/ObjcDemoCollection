//
//  HYDDatePickerView.h
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/2/11.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HYDDatePickerConfirmHandler)(NSString *dateString);

@interface HYDDatePickerView : UIView

@property (nonatomic, copy) HYDDatePickerConfirmHandler confirmHandler;

+ (HYDDatePickerView *)datePickerView;
- (void)showInView:(UIView *)view handler:(HYDDatePickerConfirmHandler)confirmHandler;

@end
