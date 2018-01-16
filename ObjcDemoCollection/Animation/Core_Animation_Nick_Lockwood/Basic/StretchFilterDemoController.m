//
//  StretchFilterDemoController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/27.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "StretchFilterDemoController.h"

#define kDigitViewSize 40
#define kDigitCount 6

@interface StretchFilterDemoController ()

//@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *digitViews;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSMutableArray *digitViews;
@property (nonatomic, weak) NSTimer *timer;


@end

@implementation StretchFilterDemoController
/*
 
 CALayer提供三种拉伸过滤方法
 * （1）kCAFilterLinear：双线性滤波算法。
 通过对多个像素取样最终生成新的值，得到一个平滑的表现不错的拉伸。但是当放大倍数比较大的时候图片就模糊不清了。
 * （2）kCAFilterTrilinear：三线性滤波算法。
 存储了多个大小情况下的图片（也叫多重贴图），并三维取样，同时结合大图和小图的存储进而得到最后的结果。这个方法的好处在于算法能够从一系列已经接近于最终大小的图片中得到想要的结果，也就是说不要对很多像素同步取样。这不仅提高了性能，也避免了小概率因舍入错误引起的取样失灵的问题
 * （3）kCAFilterNearest：最近过滤算法。
 取样最近的单像素点而不管其他的颜色。这样做非常快，也不会使图片模糊。但是，最明显的效果就是，会使得压缩图片更糟，图片放大之后也显得块状或是马赛克严重。
 
 对于大图来说，双线性滤波和三线性滤波表现得更出色。
 对于没有斜线的小图来说，最近过滤算法要好很多。
 
 `minificationFilter`和`magnificationFilter`
 
 
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set up container view
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDigitViewSize * kDigitCount, kDigitViewSize)];
    self.containerView.center = self.view.center;
    [self.view addSubview:self.containerView];
    
    // create digit views
    self.digitViews = @[].mutableCopy;
    for (int i = 0; i < kDigitCount; i++) {
        CGFloat w = kDigitViewSize;
        CGFloat h = kDigitViewSize;
        CGFloat x = i * w;
        CGFloat y = 0;
        UIView *digitView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [self.containerView addSubview:digitView];
        [self.digitViews addObject:digitView];
    }
    
    // set up digit view content
    UIImage *digits = [UIImage imageNamed:@"Digits"];
    for (UIView *view in self.digitViews) {
        view.layer.contents = (__bridge id)digits.CGImage;
        view.layer.contentsGravity = kCAGravityResizeAspect;
        view.layer.magnificationFilter = kCAFilterNearest; // 最近过滤算法
//        view.layer.magnificationFilter = kCAFilterLinear; // 双线性滤波算法
//        view.layer.magnificationFilter = kCAFilterTrilinear; // 三线性滤波算法
    }
    
    //start timer
    WS(weakSelf);
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf tick];
    }];
    
    //set initial clock time
    [self tick];
}

- (void)setDigit:(NSInteger)digit forView:(UIView *)view
{
    view.layer.contentsRect = CGRectMake(digit * 0.1, 0, 0.1, 1.0);
}

- (void)tick
{
    //convert time to hours, minutes and seconds
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    
    //set hours
    [self setDigit:components.hour / 10 forView:self.digitViews[0]];
    [self setDigit:components.hour % 10 forView:self.digitViews[1]];
    
    //set minutes
    [self setDigit:components.minute / 10 forView:self.digitViews[2]];
    [self setDigit:components.minute % 10 forView:self.digitViews[3]];
    
    //set seconds
    [self setDigit:components.second / 10 forView:self.digitViews[4]];
    [self setDigit:components.second % 10 forView:self.digitViews[5]];
}

@end
