//
//  CommentsView.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/3/27.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "CommentsView.h"

static const CGFloat kAnimationDuration = 0.35;

@interface CommentsView()

@property (nonatomic, strong) UIScrollView *commentsArea;
@property (nonatomic, strong, nonnull) UIView *testView;

@end

@implementation CommentsView

- (instancetype)init
{
    if (self = [super init]) {
        [self layoutPageSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self layoutPageSubviews];
    }
    return self;
}

#pragma mark - public
- (void)showInView:(UIView *)view
{
    [view addSubview:self];
    
    CGRect originFrame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height/2);
    CGRect destinationFrame = CGRectMake(0, self.bounds.size.height/2, self.bounds.size.width, self.bounds.size.height/2);
    
    self.commentsArea.frame = originFrame;
    [UIView animateWithDuration:kAnimationDuration delay:0.0 usingSpringWithDamping:0.9 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.commentsArea.frame = destinationFrame;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - private
- (void)layoutPageSubviews
{
    self.frame = self.bounds;
    self.backgroundColor = RGBA(0, 0, 0, 0.01);
    
    self.commentsArea = [[UIScrollView alloc] init];
    self.commentsArea.frame = CGRectMake(0, self.bounds.size.height/2, self.bounds.size.width, self.bounds.size.height/2);
    self.commentsArea.backgroundColor = [UIColor magentaColor];
    [self addSubview:self.commentsArea];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.commentsArea.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.commentsArea.bounds;
    maskLayer.path = maskPath.CGPath;
    self.commentsArea.layer.mask = maskLayer;
}

- (void)dismiss
{
    self.commentsArea.frame = CGRectMake(0, self.bounds.size.height/2, self.bounds.size.width, self.bounds.size.height/2);
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.commentsArea.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height/2);
    } completion:^(BOOL finished) {
        [self.commentsArea removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    point = [self.commentsArea.layer convertPoint:point fromLayer:self.layer];

    if (![self.commentsArea.layer containsPoint:point]) {
        [self dismiss];
    }
}

@end
