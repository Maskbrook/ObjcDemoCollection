//
//  CheckAppVersionManager.h
//  ObjectiveCSummmaryDemo
//
//  Created by jiabaozhang on 17/5/8.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class AppstoreInfo;

typedef void(^CheckAppVersionBlock)(AppstoreInfo *appInfo);

@interface CheckAppVersionManager : NSObject

/**
 *  检测新版本(使用系统默认提示框)
 *
 *  appID:应用在Store里面的ID (应用的AppStore地址里面可获取)
 *  containCtrl: 提示框显示在哪个控制器上
 */
+(void)checkNewEditionWithAppID:(NSString *)appID containCtrl:(UIViewController *)containCtrl;

/**
 *  检测新版本(使用自定义提示框)
 *
 *  appID:应用在Store里面的ID (应用的AppStore地址里面可获取)
 *  checkVersionBlock AppStore上版本信息回调block
 */
+(void)checkNewEditionWithAppID:(NSString *)appID CustomAlert:(CheckAppVersionBlock)checkVersionBlock;

@end
