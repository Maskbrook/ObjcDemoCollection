//
//  PPDeviceInfo.h
//  ObjectiveCSummmaryDemo
//
//  Created by jiabaozhang on 17/5/8.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PPDeviceInfo : NSObject

/**
 *  method  获取设备IDFA
 *  @return 设备IDFA
 */
+(NSString *)dy_getDeviceIDFA;

/**
 *  method  获取设备IDFV
 *  @return 设备IDFV
 */
+(NSString *)dy_getDeviceIDFV;

/**
 *  method  获取设备MAC
 *  @return 设备MAC
 */
+(NSString*)dy_getDeviceMAC;

/**
 *  method  获取设备UUID
 *  @return 设备UUID
 */
+(NSString*)dy_getDeviceUUID;

/**
 *  method  获取设备IMEI
 *  @return 设备IMEI
 */
+(NSString*)dy_getDeviceIMEI;

/**
 *  method  获取设备UDID
 *  @return 设备UDID
 */
+(NSString*)dy_getDeviceUDID;

@end
