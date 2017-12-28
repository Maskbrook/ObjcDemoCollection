//
//  GeometryDemoController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/26.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "GeometryDemoController.h"
#import "NSTimer+Helper.h"

@interface GeometryDemoController ()

@property (nonatomic, strong) UIImageView *faceView;
@property (nonatomic, strong) UIImageView *hourHand;
@property (nonatomic, strong) UIImageView *minuteHand;
@property (nonatomic, strong) UIImageView *secondHand;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation GeometryDemoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self layoutPageSubviews];
    [self adjustAnchorPoint];
    [self tick];
    [self startTimer];
}

#pragma mark - private methods

- (void)adjustAnchorPoint
{
    self.secondHand.layer.anchorPoint = CGPointMake(0.5, 0.9);
    self.minuteHand.layer.anchorPoint = CGPointMake(0.5, 0.9);
    self.hourHand.layer.anchorPoint = CGPointMake(0.5, 0.9);
}

- (void)layoutPageSubviews
{
    [self.view addSubview:self.faceView];
    [self.view addSubview:self.hourHand];
    [self.view addSubview:self.minuteHand];
    [self.view addSubview:self.secondHand];
    
    WS(ws);
    [self.faceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws.view);
    }];
    [self.hourHand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws.view);
    }];
    [self.minuteHand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws.view);
    }];
    [self.secondHand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws.view);
    }];
}

- (void)startTimer
{
    WS(weakSelf);
    self.timer = [NSTimer hyd_scheduledTimerWithTimeInterval:1.0 block:^{
        [weakSelf tick];
    } repeats:YES];
}

- (void)stopTimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)dealloc
{
    [self stopTimer];
}

- (void)tick
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    
    CGFloat hoursAngle = (components.hour / 12.0) * M_PI * 2.0;
    CGFloat minsAngle = (components.minute / 60.0) * M_PI * 2.0;
    CGFloat secsAngle = (components.second / 60.0) * M_PI * 2.0;
    
    self.hourHand.transform = CGAffineTransformMakeRotation(hoursAngle);
    self.minuteHand.transform = CGAffineTransformMakeRotation(minsAngle);
    self.secondHand.transform = CGAffineTransformMakeRotation(secsAngle);
}

#pragma mark - getters
- (UIImageView *)faceView
{
    if (_faceView == nil) {
        _faceView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ClockFace"]];
    }
    return _faceView;
}

- (UIImageView *)hourHand
{
    if (_hourHand == nil) {
        _hourHand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HourHand"]];
    }
    return _hourHand;
}

- (UIImageView *)minuteHand
{
    if (_minuteHand == nil) {
        _minuteHand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MinuteHand"]];
    }
    return _minuteHand;
}

- (UIImageView *)secondHand
{
    if (_secondHand == nil) {
        _secondHand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SecondHand"]];
    }
    return _secondHand;
}

@end
