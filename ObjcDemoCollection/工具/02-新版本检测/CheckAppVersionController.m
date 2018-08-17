//
//  CheckAppVersionController.m
//  ObjectiveCSummmaryDemo
//
//  Created by jiabaozhang on 17/5/8.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "CheckAppVersionController.h"
#import "CheckAppVersionManager.h"
#import "AppstoreInfo.h"

@interface CheckAppVersionController ()

@end

@implementation CheckAppVersionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self checkAppVersion];
}

- (void)checkAppVersion
{
    [CheckAppVersionManager checkNewEditionWithAppID:@"1142110895" containCtrl:self];
    
//    [CheckAppVersionManager checkNewEditionWithAppID:@"1142110895" CustomAlert:^(AppstoreInfo *appInfo) {
//        // 在这里使用自定义的提示框
//        NSLog(@"AppstoreInfo : %@", [appInfo description]);
//    }];
}

@end
