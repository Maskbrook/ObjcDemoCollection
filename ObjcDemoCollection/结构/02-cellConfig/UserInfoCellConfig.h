//
//  UserInfoCellConfig.h
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/4/19.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoCellConfig : NSObject

@property (nonatomic, copy) NSString *titleOfCell;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, assign) BOOL isPicker; //是否是选择器


+ (NSArray<UserInfoCellConfig *> *)getConfig;
- (CGFloat)cellHeight;

@end
