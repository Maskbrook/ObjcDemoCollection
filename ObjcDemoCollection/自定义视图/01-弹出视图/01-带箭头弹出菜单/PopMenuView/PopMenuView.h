//
//  PopMenuView.h
//  CustomPopMenuView
//
//  Created by jiabaozhang on 17/4/10.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopMenuView : UIView

/**
 *  创建menuView
 */
+ (PopMenuView *)popMenuView;


/**
 *  显示menuView
 *  arrow_middle_x：箭头指向的点的x值
 *  menu_original_x：menuView左上角x值
 *  menu_original_y：menuView左上角y值
 *  width：menuView宽度
 */
- (void)showItems:(NSArray *)items arrow_middle_x:(CGFloat)arrow_middle_x menu_original_x:(CGFloat)menu_original_x menu_original_y:(CGFloat)menu_original_y width:(CGFloat)width;
@end
