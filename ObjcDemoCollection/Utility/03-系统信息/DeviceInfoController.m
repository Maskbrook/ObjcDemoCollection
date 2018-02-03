//
//  DeviceInfoController.m
//  ObjectiveCSummmaryDemo
//
//  Created by jiabaozhang on 17/5/8.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "DeviceInfoController.h"
#import "PPDeviceInfo.h"

@interface DeviceInfoController ()

@end

@implementation DeviceInfoController
{
    UILabel *macLabel;
    UILabel *idfaLabel;
    UILabel *idfvLabel;
    UILabel *imeiLabel;
    UILabel *udidLabel;
    UILabel *uuidLabel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutPageSubviews];
}

- (void)layoutPageSubviews
{
    macLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
    macLabel.numberOfLines = 0;
    macLabel.font = FONT(13);
    macLabel.backgroundColor = [UIColor redColor];
    macLabel.text = [PPDeviceInfo dy_getDeviceMAC];
    [self.view addSubview:macLabel];
    
    idfaLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 140, 200, 40)];
    idfaLabel.numberOfLines = 0;
    idfaLabel.font = FONT(13);
    idfaLabel.backgroundColor = [UIColor greenColor];
    idfaLabel.text = [PPDeviceInfo dy_getDeviceIDFA];
    [self.view addSubview:idfaLabel];
    
    idfvLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 180, 200, 40)];
    idfvLabel.numberOfLines = 0;
    idfvLabel.font = FONT(13);
    idfvLabel.backgroundColor = [UIColor magentaColor];
    idfvLabel.text = [PPDeviceInfo dy_getDeviceIDFV];
    [self.view addSubview:idfvLabel];
    
    imeiLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 220, 200, 40)];
    imeiLabel.numberOfLines = 0;
    imeiLabel.font = FONT(13);
    imeiLabel.backgroundColor = [UIColor purpleColor];
    imeiLabel.text = [PPDeviceInfo dy_getDeviceIMEI];
    [self.view addSubview:imeiLabel];
    
    udidLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 260, 200, 40)];
    udidLabel.numberOfLines = 0;
    udidLabel.font = FONT(13);
    udidLabel.backgroundColor = [UIColor grayColor];
    udidLabel.text = [PPDeviceInfo dy_getDeviceUDID];
    [self.view addSubview:udidLabel];
    
    uuidLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 200, 40)];
    uuidLabel.numberOfLines = 0;
    uuidLabel.font = FONT(13);
    uuidLabel.backgroundColor = [UIColor brownColor];
    uuidLabel.text = [PPDeviceInfo dy_getDeviceUUID];
    [self.view addSubview:uuidLabel];
}


@end
