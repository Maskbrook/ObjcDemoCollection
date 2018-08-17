//
//  CommentsViewController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/3/27.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "CommentsViewController.h"
#import "CommentsView.h"

@interface CommentsViewController ()

@property (nonatomic, strong) CommentsView *cmView;

@end

@implementation CommentsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *showMenuButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    showMenuButton.backgroundColor = [UIColor magentaColor];
    [showMenuButton setTitle:@"show" forState:UIControlStateNormal];
    [self.view addSubview:showMenuButton];
    
    WS(weakSelf);
    showMenuButton.actionBlock = ^{
        weakSelf.cmView = [[CommentsView alloc] initWithFrame:self.view.bounds];
        [weakSelf.cmView showInView:[UIApplication sharedApplication].keyWindow];
    };
}

@end
