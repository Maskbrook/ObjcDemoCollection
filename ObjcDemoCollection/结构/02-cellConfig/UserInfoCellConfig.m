//
//  UserInfoCellConfig.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/4/19.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "UserInfoCellConfig.h"

@implementation UserInfoCellConfig

- (CGFloat)cellHeight
{
    return 50;
}

+ (NSArray<UserInfoCellConfig *> *)defaultConfig
{
    NSArray *titles = @[@"参保单位", @"开始缴纳社保时间", @"社保缴纳基数", @"公积金缴纳基数"];
    NSArray *holders = @[@"输入", @"请选择", @"输入", @"输入"];
    NSArray *isPickers = @[@NO, @YES, @NO, @NO];
    NSArray *keyboardTypes = @[@(UIKeyboardTypeAlphabet),
                               @(UIKeyboardTypeAlphabet),
                               @(UIKeyboardTypeNumberPad),
                               @(UIKeyboardTypeNumberPad)];
    
    NSMutableArray *mArray = @[].mutableCopy;
    
    for (int i = 0; i < titles.count; i++) {
        UserInfoCellConfig *config = [[UserInfoCellConfig alloc] init];
        config.titleOfCell = titles[i];
        config.placeholder = holders[i];
        config.isPicker = [isPickers[i] boolValue];
        config.keyboardType = [keyboardTypes[i] integerValue];
        [mArray addObject:config];
    }
    return mArray;
}

+ (NSArray<UserInfoCellConfig *> *)otherConfig
{
    NSArray *titles = @[@"单位", @"开始时间", @"社保基数", @"公积金基数"];
    NSArray *holders = @[@"请输入单位名称", @"请选择", @"", @"输入"];
    NSArray *isPickers = @[@NO, @NO, @YES, @NO];
    NSArray *keyboardTypes = @[@(UIKeyboardTypeAlphabet),
                               @(UIKeyboardTypeNumberPad),
                               @(UIKeyboardTypeAlphabet),
                               @(UIKeyboardTypeNumberPad)];
    
    NSMutableArray *mArray = @[].mutableCopy;
    
    for (int i = 0; i < titles.count; i++) {
        UserInfoCellConfig *config = [[UserInfoCellConfig alloc] init];
        config.titleOfCell = titles[i];
        config.placeholder = holders[i];
        config.isPicker = [isPickers[i] boolValue];
        config.keyboardType = [keyboardTypes[i] integerValue];
        [mArray addObject:config];
    }
    return mArray;
}

@end
