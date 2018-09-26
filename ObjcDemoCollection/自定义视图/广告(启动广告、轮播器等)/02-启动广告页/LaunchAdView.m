//
//  LaunchAdView.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/3/27.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "LaunchAdView.h"

@interface LaunchAdView()

@property (nonatomic, strong) UIImageView *backgroundimgView;
@property (nonatomic, strong) UIButton *countDownButton;
@property (nonatomic, strong) UIView *circleView;
@property (nonatomic, weak) CAShapeLayer *viewLayer;

@property (nonatomic, assign) NSTimeInterval count;
@property (nonatomic, assign) NSTimeInterval remain;

@end

@implementation LaunchAdView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commitUI];
    }
    return self;
}

#pragma mark - public
- (void)dismiss
{
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 0.0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
    }];
}

#pragma mark - UI
//确认UI
- (void)commitUI
{
    [self getBackgroundImgView];
    [self getCountDownButton];
    [self getCircleView];
}

- (void)getCircleView
{
    self.circleView = [[UIView alloc] initWithFrame:CGRectMake(20, 35, 36, 36)];
    self.circleView.backgroundColor = [UIColor lightGrayColor];
    self.circleView.layer.cornerRadius = 17;
    self.circleView.clipsToBounds = YES;
    [self addSubview:self.circleView];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4].CGColor;
    layer.strokeColor = [UIColor magentaColor].CGColor;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    layer.lineWidth = 2;
    layer.path = [self getCirclePath].CGPath;
    layer.strokeStart = 0;
    [self.circleView.layer addSublayer:layer];
    self.viewLayer = layer;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:self.circleView.bounds];
    titleLabel.text = @"跳过";
    titleLabel.textColor = [UIColor whiteColor];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.font = FONT(11);
    [self.circleView addSubview:titleLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.circleView addGestureRecognizer:tap];
}

- (void)getCountDownButton
{
    self.countDownButton = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - 90, 35, 70, 35)];
    self.countDownButton.layer.cornerRadius = 17;
    self.countDownButton.clipsToBounds = YES;
    self.countDownButton.titleLabel.font = FONT(14);
    self.countDownButton.backgroundColor = [UIColor lightGrayColor];
    [self.countDownButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.countDownButton];
}

- (void)getBackgroundImgView
{
    self.backgroundimgView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.backgroundimgView.image = [UIImage imageNamed:@"lanuch.jpg"];
    [self addSubview:self.backgroundimgView];
}

- (UIBezierPath *)getCirclePath
{
    return [UIBezierPath bezierPathWithArcCenter:CGPointMake(18, 18) radius:17 startAngle:-0.5*M_PI endAngle:1.5*M_PI clockwise:YES];
}

#pragma mark - setters
- (void)setDuration:(NSTimeInterval)duration
{
    _duration = duration;
}

- (void)setType:(LaunchType)type
{
    _type = type;
    
    if (type == LaunchTypeCountButton) {
        [self startCoundown];
        self.circleView.hidden = YES;
    } else if (type == LaunchTypeCircle) {
        [self circleTimerCountDown];
        self.countDownButton.hidden = YES;
    }
}

#pragma mark - private
//环形倒计时
- (void)circleTimerCountDown
{
    self.count = 0;
    CGFloat ratio = 0.05; //每0.05秒调用一次
    self.remain = self.duration * (1.0 / ratio);
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), ratio * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.count >= self.remain) {
                dispatch_source_cancel(timer);
                self.viewLayer.strokeStart = 1;
                [self dismiss];
            } else {
                self.viewLayer.strokeStart += 0.01;
                self.count++;
            }
        });
    });
    dispatch_resume(timer);
}

//GCD倒计时
- (void)startCoundown
{
    __block int timeout = self.duration + 1;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismiss];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_countDownButton setTitle:[NSString stringWithFormat:@"%d 跳过",timeout] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

@end
