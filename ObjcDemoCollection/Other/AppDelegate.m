//
//  AppDelegate.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/20.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "GuidePageView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - ## private methods
//确认根控制器
- (void)confirmRootController
{
    HomeViewController *home = [[HomeViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:home];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}

//确认引导页
- (void)confirmGuideView
{
    GuidePageView *guidePageView = [[GuidePageView alloc] initWithFrame:[UIScreen mainScreen].bounds images:@[@"Intro_1", @"Intro_2", @"Intro_3"]];
    [self.window addSubview:guidePageView];
}

//确认launchScreen样式
- (void)confirmLaunchScreen
{
    UIViewController *controller = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    [mainWindow addSubview:controller.view];
    [self.window bringSubviewToFront:controller.view];
    
    for (UIView *subView in controller.view.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            NSLog(@"=====%@=====",((UILabel *)subView).text);
        }
    }
    
    [UIView animateWithDuration:0.35 delay:3.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        controller.view.alpha = 0.0f;
        controller.view.layer.transform = CATransform3DScale(CATransform3DIdentity, 2.0f, 2.0f, 1.0f);
    } completion:^(BOOL finished) {
        [controller.view removeFromSuperview];
    }];
}

#pragma mark -  ## appdelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //step1: 根控制器
    [self confirmRootController];
    //step2: 引导页
    [self confirmGuideView];
    //step3: launchScreen
    [self confirmLaunchScreen];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
