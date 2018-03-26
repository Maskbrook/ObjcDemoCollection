//
//  PopMenuView.m
//  CustomPopMenuView
//
//  Created by jiabaozhang on 17/4/10.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "PopMenuView.h"
#import "PopMenuViewCell.h"
#import "PopMenuItem.h"

#define kPopMenuViewCellHeight 40.0
#define kArrowHeight 12.0
#define kPopAnimationDuration 0.35


@interface PopMenuView ()<UITableViewDataSource, UITableViewDelegate>

// UI
@property (nonatomic, strong) UIWindow *keyWindow;
@property (nonatomic, strong) UIView *shadeView;
@property (nonatomic, strong) UITableView *tableView;

// DATA
@property (nonatomic, strong) NSArray *items;

@end

@implementation PopMenuView

#pragma mark - init
- (instancetype)init
{
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.keyWindow = [UIApplication sharedApplication].keyWindow;
    
    self.shadeView = [[UIView alloc] initWithFrame:self.keyWindow.bounds];
    self.shadeView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.1];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self.shadeView addGestureRecognizer:tap];
    [self.keyWindow addSubview:self.shadeView];
    
    self.backgroundColor = [UIColor clearColor];
    [self.keyWindow addSubview:self];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = false;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.layer.cornerRadius = 8.0;
    self.tableView.clipsToBounds = true;
    [self addSubview:self.tableView];
}

#pragma mark - private
- (void)hide
{
    [UIView animateWithDuration:kPopAnimationDuration animations:^{
        self.alpha = 0.f;
        self.shadeView.alpha = 0.f;
        self.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    } completion:^(BOOL finished) {
        [self.shadeView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma mark - public
+ (PopMenuView *)popMenuView
{
    return [[self alloc] init];
}

- (void)showItems:(NSArray *)items arrow_middle_x:(CGFloat)arrow_middle_x menu_original_x:(CGFloat)menu_original_x menu_original_y:(CGFloat)menu_original_y width:(CGFloat)width
{
    self.items = [items copy];
    
    // set frame
    self.frame = CGRectMake(menu_original_x, menu_original_y, width, (kArrowHeight+self.items.count*kPopMenuViewCellHeight));
    self.tableView.frame = CGRectMake(0, kArrowHeight, width, self.items.count*kPopMenuViewCellHeight);
    
    // draw triangle
    CGPoint arrowTop = CGPointMake(arrow_middle_x, 0);
    CGPoint arrowLeft = CGPointMake(arrow_middle_x-10, kArrowHeight);
    CGPoint arrowRight = CGPointMake(arrow_middle_x+10, kArrowHeight);
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    [aPath moveToPoint:arrowTop];
    [aPath addLineToPoint:arrowRight];
    [aPath addLineToPoint:arrowLeft];
    [aPath closePath];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [aPath CGPath];
    shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
    [self.layer addSublayer:shapeLayer];
    
    // show animation
    CGRect oldFrame = self.frame;
    self.layer.anchorPoint = CGPointMake(arrowTop.x/self.frame.size.width, 0.f);
    self.frame = oldFrame;
    self.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    [UIView animateWithDuration:kPopAnimationDuration animations:^{
        self.transform = CGAffineTransformIdentity;
        self.shadeView.alpha = 1.f;
    }];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseID = @"PopMenuViewCell";
    PopMenuViewCell *cell = [[PopMenuViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    }
    
    [cell updatePopMenuItem:self.items[indexPath.row]];
    [cell bottomLineShouldHide:(indexPath.row >= self.items.count - 1)];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kPopMenuViewCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [UIView animateWithDuration:kPopAnimationDuration animations:^{
        self.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
        self.alpha = 0.f;
        self.shadeView.alpha = 0.f;
    } completion:^(BOOL finished) {
        PopMenuItem *item = self.items[indexPath.row];
        item.handler ? item.handler(item) : NULL;
        item.handler = nil;
        [self.shadeView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

@end
