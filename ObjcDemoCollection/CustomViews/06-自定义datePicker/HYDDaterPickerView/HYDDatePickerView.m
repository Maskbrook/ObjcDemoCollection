//
//  HYDDatePickerView.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/2/11.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "HYDDatePickerView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

static const CGFloat kAnimationDuration = 0.35;
static const CGFloat kPadding = 20;
static const CGFloat kPickerViewWidth = 300;
static const CGFloat kPickerViewHeight = 240;


@interface HYDDatePickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSDate *fromDate;//开始日期
@property (nonatomic, strong) NSDate *toDate;//结束日期
@property (nonatomic, copy) NSString *userSelectedDateString;//选中的日期

@end

@implementation HYDDatePickerView
{
    NSString *_fromDateString;//开始日期
    NSString *_toDateString;//结束日期
}

#pragma mark - init
- (instancetype)init
{
    if (self = [super init]) {
        [self layoutPageSubviews];
        [self initDate];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self layoutPageSubviews];
        [self initDate];
    }
    return self;
}

#pragma mark - private methods
- (void)initDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *conponent = [calendar components:unitFlags fromDate:[NSDate date]];
    NSInteger year = [conponent year];
    NSInteger month = [conponent month];
    NSInteger day = [conponent day];
    
    _fromDateString = @"1991-01-01";
    _toDateString = [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)year,(long)month,(long)day];
    self.fromDate = [self dateFromString:_fromDateString];
    self.toDate = [self dateFromString:_toDateString];
    
    //默认选中当前日期
    self.userSelectedDateString = [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)year,(long)month,(long)day];
    NSDateComponents *comCenter = [calendar components:unitFlags fromDate:self.fromDate toDate:self.toDate options:0];
    [self.pickerView selectRow:comCenter.year inComponent:0 animated:YES];
    [self.pickerView selectRow:month-1 inComponent:1 animated:YES];
    [self.pickerView selectRow:day-1 inComponent:2 animated:YES];
}

- (void)layoutPageSubviews
{
    self.frame = [[UIScreen mainScreen] bounds];
    self.backgroundColor = RGBA(0, 0, 0, 0.2);
    
    self.containerView = [[UIView alloc] init];
    [self addSubview:self.containerView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self addGestureRecognizer:tap];
    
    [self.containerView addSubview:self.cancelButton];
    [self.containerView addSubview:self.confirmButton];
    [self.containerView addSubview:self.pickerView];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kPickerViewWidth);
        make.height.mas_equalTo(kPickerViewHeight);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-kPadding);
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
    self.containerView.frame = CGRectMake((ScreenWidth - kPickerViewWidth)/2, (ScreenHeight-kPickerViewHeight-kPadding), kPickerViewWidth, kPickerViewHeight);
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.containerView.frame = CGRectMake((ScreenWidth - kPickerViewWidth)/2, ScreenHeight, kPickerViewWidth, kPickerViewHeight);
    } completion:^(BOOL finished) {
        [self.containerView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma mark - public methods
+ (HYDDatePickerView *)datePickerView
{
    return [[self alloc] init];
}

- (void)showInView:(UIView *)view handler:(HYDDatePickerConfirmHandler)confirmHandler
{
    [view addSubview:self];
    CGRect originFrame = CGRectMake((ScreenWidth - kPickerViewWidth)/2, ScreenHeight, kPickerViewWidth, kPickerViewHeight);
    CGRect destinationFrame = CGRectMake((ScreenWidth - kPickerViewWidth)/2, (ScreenHeight-kPickerViewHeight-kPadding), kPickerViewWidth, kPickerViewHeight);
    self.containerView.frame = originFrame;
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.containerView.frame = destinationFrame;
    } completion:nil];
    
    self.confirmHandler = confirmHandler ?: NULL;
}

#pragma mark - UIPickerView delegate & datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear;
    if (_toDateString.length) {
        self.toDate = [self dateFromString:_toDateString];
    }else{
        self.toDate = [NSDate date];
    }
    NSDateComponents * conponent= [calendar components:unitFlags fromDate:self.fromDate toDate:self.toDate options:0];
    if (component == 0) {
        return ([conponent year] + 1);
    } else if (component == 1) {
        return 12;
    } else if (component == 2) {
        return 31;
    }
    return 12;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return (kPickerViewWidth / 3);
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        NSDate *fromDate = [self dateFromString:_fromDateString];
        NSDateComponents *conponent= [calendar components:unitFlags fromDate:fromDate];
        return [NSString stringWithFormat:@"%02ld年",(long)[conponent year] + row];
    }else if (component == 1){
        return [NSString stringWithFormat:@"%02ld月",(long)1 + row];
    }else if (component == 2){
        return [NSString stringWithFormat:@"%02ld日",(long)1 + row];
    }
    return @"";
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        pickerLabel.font = FONT(15);
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self pickerViewLoaded:component];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay;
    NSDateComponents *comFrom = [calendar components:unitFlags fromDate:self.fromDate];
    NSDateComponents *comEnd = [calendar components:unitFlags fromDate:self.toDate];
    
    if (([self.pickerView selectedRowInComponent:0] == 0) &&
        ([self.pickerView selectedRowInComponent:1] < comFrom.month - 1)) {
        [self.pickerView selectRow:comFrom.month - 1 inComponent:1 animated:YES];
    }
    
    if (([self.pickerView selectedRowInComponent:0] == 0) &&
        ([self.pickerView selectedRowInComponent:1] <= comFrom.month - 1) &&
        ([self.pickerView selectedRowInComponent:2] < comFrom.day - 1)) {
        [self.pickerView selectRow:comFrom.day-1 inComponent:2 animated:YES];
    }
    
    if (comFrom.year + [self.pickerView selectedRowInComponent:0] > comEnd.year) {
        [self.pickerView selectRow:comEnd.year inComponent:0 animated:YES];
    }
    
    if ((comFrom.year+[self.pickerView selectedRowInComponent:0] >= comEnd.year) &&
        ([self.pickerView selectedRowInComponent:1] > comEnd.month - 1)) {
        [self.pickerView selectRow:comEnd.month-1 inComponent:1 animated:YES];
    }
    if ((comFrom.year+[self.pickerView selectedRowInComponent:0] >= comEnd.year) &&
        ([self.pickerView selectedRowInComponent:1] >= comEnd.month - 1) &&
        ([self.pickerView selectedRowInComponent:2] > comEnd.day - 1)) {
        [self.pickerView selectRow:comEnd.day-1 inComponent:2 animated:YES];
    }
    
    //1,3,5,7,8,10,12 有31天
    // 4,6,9,11 有30天
    if ([self.pickerView selectedRowInComponent:1] == 4-1
        ||[self.pickerView selectedRowInComponent:1] == 6-1
        ||[self.pickerView selectedRowInComponent:1] == 9-1
        ||[self.pickerView selectedRowInComponent:1] == 11-1) {
        
        if ([self.pickerView selectedRowInComponent:2] >= 31-1) {
            [self.pickerView selectRow:30-1 inComponent:2 animated:YES];
        }
    }
    NSInteger seletedYear = comFrom.year + [self.pickerView selectedRowInComponent:0];
    //四年一闰 百年不闰 四百年一闰
    if ([self.pickerView selectedRowInComponent:1] == 2-1) {
        if (!(seletedYear % 400)||(seletedYear % 100 && !(seletedYear % 4))) {
            if ([self.pickerView selectedRowInComponent:2] > 29-1) {
                [self.pickerView selectRow:29-1 inComponent:2 animated:YES];
            }
        } else {
            if ([self.pickerView selectedRowInComponent:2] > 28-1) {
                [self.pickerView selectRow:28-1 inComponent:2 animated:YES];
            }
        }
    }

    self.userSelectedDateString = [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)comFrom.year+(long)[self.pickerView selectedRowInComponent:0],(long)[self.pickerView selectedRowInComponent:1]+1,(long)[self.pickerView selectedRowInComponent:2]+1];
}

- (void)pickerViewLoaded:(NSInteger)component
{
    NSUInteger max = 16384;
    NSUInteger base10 = (max / 2) - (max / 2) % (component ? 4 : 24);
    [self.pickerView selectRow:[self.pickerView selectedRowInComponent:component] % (component ? 4 : 24) + base10 inComponent:component animated:NO];
}

#pragma mark - date related methods
//字符串转日期
- (NSDate *)dateFromString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

#pragma mark - event response
- (void)cancelButtonAction:(UIButton *)sender
{
    [self dismiss];
}

- (void)confirmButtonAction:(UIButton *)sender
{
    if (self.confirmHandler) {
        self.confirmHandler(self.userSelectedDateString);
    }
    [self dismiss];
}

#pragma mark - getters & setters

- (UIPickerView *)pickerView
{
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.backgroundColor = RGBA(231, 231, 231, 1);
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
    }
    return _pickerView;
}

- (UIButton *)cancelButton
{
    if (_cancelButton == nil) {
        _cancelButton = [[UIButton alloc] init];
        _cancelButton.backgroundColor = RGBA(220, 220, 220, 1);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = FONT(15);
        [_cancelButton setTitleColor:RGBA(101, 101, 101, 1) forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)confirmButton
{
    if (_confirmButton == nil) {
        _confirmButton = [[UIButton alloc] init];
        _confirmButton.backgroundColor = RGBA(220, 220, 220, 1);
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = FONT(15);
        [_confirmButton setTitleColor:RGBA(16, 168, 234, 1) forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

@end
