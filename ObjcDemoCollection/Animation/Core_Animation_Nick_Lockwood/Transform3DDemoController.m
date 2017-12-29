//
//  Transform3DDemoController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/29.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "Transform3DDemoController.h"

@interface Transform3DDemoController ()

@end

@implementation Transform3DDemoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self layoutPageSubviews];
}


#pragma mark - Private Methods
- (void)layoutPageSubviews
{
    WS(ws);
    // set up matrix image
    UIImageView *matrixImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"matrix_transform3D_4x4"]];
    [self.view addSubview:matrixImg];
    [matrixImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(270));
        make.height.equalTo(@(90));
        make.top.mas_equalTo(ws.view.mas_top).offset(70);
        make.centerX.mas_equalTo(ws.view.mas_centerX);
    }];
}

@end
