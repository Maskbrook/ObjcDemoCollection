//
//  HYDDatePickerView.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/2/11.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "HYDDatePickerView.h"

static const CGFloat kPickerViewWidth = 300;
static const CGFloat kPickerViewHeight = 240;
static const CGFloat kAnimationDuration = 0.35;

@interface HYDDatePickerView ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation HYDDatePickerView

#pragma mark - init
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

#pragma mark - public methods
+ (HYDDatePickerView *)datePickerView
{
    return [[self alloc] init];
}

#pragma mark - private methods
- (void)layoutPageSubviews
{
    [self addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.containerView];
    [self.containerView addSubview:self.cancelButton];
    [self.containerView addSubview:self.confirmButton];
    [self.containerView addSubview:self.pickerView];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self.mas_right);
    }];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kPickerViewWidth);
        make.height.mas_equalTo(kPickerViewHeight);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kPickerViewWidth/2);
        make.height.mas_equalTo(44);
        make.left.mas_equalTo(self.containerView.mas_left);
        make.top.mas_equalTo(self.containerView.mas_top);
    }];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kPickerViewWidth/2);
        make.height.mas_equalTo(44);
        make.right.mas_equalTo(self.containerView.mas_right);
        make.top.mas_equalTo(self.containerView.mas_top);
    }];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.containerView.mas_left);
        make.right.mas_equalTo(self.containerView.mas_right);
        make.top.mas_equalTo(self.cancelButton.mas_bottom);
        make.bottom.mas_equalTo(self.containerView.mas_bottom);
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.alpha = 0.f;
        self.backgroundView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma mark - UIPickerView delegate & datasource

#pragma mark - event response
- (void)cancelButtonAction:(UIButton *)sender
{
    [self dismiss];
}

- (void)confirmButtonAction:(UIButton *)sender
{
    if (self.HYDDatePickerViewConfimrBlock) {
        self.HYDDatePickerViewConfimrBlock(sender);
    }
    [self dismiss];
}

#pragma mark - getters & setters
- (UIView *)backgroundView
{
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = RGBA(0, 0, 0, 0.3);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [_backgroundView addGestureRecognizer:tap];
    }
    return _backgroundView;
}

- (UIView *)containerView
{
    if (_containerView == nil) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor yellowColor];
    }
    return _containerView;
}

- (UIPickerView *)pickerView
{
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.backgroundColor = [UIColor magentaColor];
    }
    return _pickerView;
}

- (UIButton *)cancelButton
{
    if (_cancelButton == nil) {
        _cancelButton = [[UIButton alloc] init];
        _cancelButton.backgroundColor = [UIColor greenColor];
        [_cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)confirmButton
{
    if (_confirmButton == nil) {
        _confirmButton = [[UIButton alloc] init];
        _confirmButton.backgroundColor = [UIColor redColor];
        [_confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

@end
