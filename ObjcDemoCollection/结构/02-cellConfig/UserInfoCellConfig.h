//
//  UserInfoCellConfig.h
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/4/19.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, UserInfoStatus) {
    UserInfoStatusDefault = 0,
    UserInfoStatusOther = 1
};

@interface UserInfoCellConfig : NSObject

@property (nonatomic, assign) UserInfoStatus status;
@property (nonatomic, copy) NSString *titleOfCell;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, assign) BOOL isPicker; //是否是选择器

//默认
+ (NSArray<UserInfoCellConfig *> *)defaultConfig;

//
+ (NSArray<UserInfoCellConfig *> *)otherConfig;

- (CGFloat)cellHeight;

@end
