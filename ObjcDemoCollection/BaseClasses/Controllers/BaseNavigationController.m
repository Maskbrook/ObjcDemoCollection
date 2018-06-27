//
//  BaseNavigationController.m
//  OCProjects
//
//  Created by jiabaozhang on 2017/12/7.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UIBarButtonItem+Helper.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

+ (void)initialize
{
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    navigationBar.barTintColor = kThemeColor;
    navigationBar.tintColor = [UIColor whiteColor];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowOffset:CGSizeZero];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
                                            NSShadowAttributeName : shadow}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置导航条的按钮
        UIBarButtonItem *popPre = [UIBarButtonItem itemWithImage:@"icon_home_back" highlightImage:@"icon_home_back" target:self action:@selector(popToPrevious)];
        viewController.navigationItem.leftBarButtonItem = popPre;
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)popToPrevious
{
    [self popViewControllerAnimated:YES];
}

@end
