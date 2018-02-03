//
//  WechatLoginController.m
//  ObjcDemoCollection
//
//  Created by 张家宝 on 2018/2/4.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "WechatLoginController.h"
#import "WechatAfterLoginController.h"
#import "SpinnerLayer.h"
#import "SpinnerButton.h"
#import "SpinnerTransition.h"

@interface WechatLoginController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UISwitch *Switch;

@end

@implementation WechatLoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutPageSubviews];
}

- (void)layoutPageSubviews
{
    // imageView
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    imgView.image = [UIImage imageNamed:@"Login"];
    [self.view addSubview:imgView];
    
    // Switch
    CGFloat switchW = 60;
    CGFloat switchH = 40;
    CGFloat padding = 10;
    UISwitch *Switch = [[UISwitch alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - switchW - padding, [UIScreen mainScreen].bounds.size.height - switchH - padding, switchW, switchH)];
    [self.view addSubview:Switch];
    self.Switch = Switch;
    
    SpinnerButton *log = [[SpinnerButton alloc] initWithFrame:CGRectMake(20, CGRectGetHeight(self.view.bounds) - (40 + 80), [UIScreen mainScreen].bounds.size.width - 40, 40)];
    [log setBackgroundColor:[UIColor colorWithRed:1 green:0.f/255.0f blue:128.0f/255.0f alpha:1]];
    [self.view addSubview:log];
    [log setTitle:@"登录" forState:UIControlStateNormal];
    [log addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)loginButtonAction:(SpinnerButton *)button
{
    typeof(self) __weak weak = self;
    //模拟网络访问
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_Switch.on) {
            //网络正常 或者是密码账号正确跳转动画
            [button exitAnimationCompletion:^{
                if (weak.Switch.on) {
                    [weak didPresentControllerButtonTouch];
                }
            }];
        } else {
            //网络错误 或者是密码不正确还原动画
            [button errorRevertAnimationCompletion:^{
                if (weak.Switch.on) {
                    [weak didPresentControllerButtonTouch];
                }
            }];
        }
    });
}


- (void)didPresentControllerButtonTouch
{
    UIViewController *controller = [WechatAfterLoginController new];
    controller.transitioningDelegate = self;
    UINavigationController *nai = [[UINavigationController alloc] initWithRootViewController:controller];
    nai.transitioningDelegate = self;
    [self presentViewController:nai animated:YES completion:nil];
}

#pragma mark - 转场动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[SpinnerTransition alloc]initWithTransitionDuration:0.4f StartingAlpha:0.5f isBOOL:true];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[SpinnerTransition alloc]initWithTransitionDuration:0.4f StartingAlpha:0.8f isBOOL:false];
}

@end
