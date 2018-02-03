//
//  WechatAfterLoginController.m
//  ObjcDemoCollection
//
//  Created by 张家宝 on 2018/2/4.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "WechatAfterLoginController.h"

@interface WechatAfterLoginController ()

@end

@implementation WechatAfterLoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutPageSubviews];
}

- (void)layoutPageSubviews
{
    UIImageView *imageview= [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imageview];
    imageview.image = [UIImage imageNamed:@"Home"];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeButtonAction)];
    [imageview setUserInteractionEnabled:true];
    [imageview addGestureRecognizer:tap];
}

- (void)closeButtonAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
