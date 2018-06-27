//
//  MasonryViewController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/5/21.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//



/*
 Masonry工作原理：
 （1）Masonry 使用分类的方式为 UIKit 添加一个方法 mas_makeConstraint, 这个方法接受了一个 block, 这个 block 有一个 MASConstraintMaker 类型的参数, 这个 maker 会持有一个约束的数组, 这里保存着所有将被加入到视图中的约束.
 
 （2）通过链式的语法配置 maker, 设置它的 left right 等属性, 比如说 make.left.equalTo(view), 其实这个 left equalTo 还有像 with offset 之类的方法都会返回一个 MASConstraint 的实例, 所以在这里才可以用类似 Ruby 中链式的语法.
 
 （3）在配置结束后, 首先会调用 maker 的 install 方法, 而这个 maker 的 install 方法会遍历其持有的约束数组, 对其中的每一个约束发送 install 消息. 在这里就会使用到在上一步中配置的属性, 初始化 NSLayoutConstraint 的子类 MASLayoutConstraint 并添加到合适的视图上.
 
 （4）视图的选择会通过调用一个方法 mas_closestCommonSuperview: 来返回两个视图的最近公共父视图.
 */

#import "MasonryViewController.h"

@interface MasonryViewController ()

@end

@implementation MasonryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutPageSubviews_001];
}

//等间隔排序多个view
- (void)layoutPageSubviews_001
{
    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    UIView *greenView = [UIView new];
    greenView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:greenView];
    
    UIView *yellowView = [UIView new];
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];
    
    UIView *brownView = [UIView new];
    brownView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:brownView];
    
    /*
     *  axisType         轴线方向
     *  fixedSpacing     间隔大小
     *  fixedItemLength  每个控件的固定长度/宽度
     *  leadSpacing      头部间隔
     *  tailSpacing      尾部间隔
     */
    

    //间隔固定，控件宽高变化
    // - (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType withFixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;

    // 控件宽高固定，间隔大小变化
    //- (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType withFixedItemLength:(CGFloat)fixedItemLength leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;
    
    NSMutableArray *mArray = @[].mutableCopy;
    [mArray addObject:redView];
    [mArray addObject:greenView];
    [mArray addObject:yellowView];
    [mArray addObject:brownView];
    
    //example : 水平布局
//    CGFloat subview_width = 50;
//    CGFloat subview_height = 70;
//    CGFloat padding_honrizental = ([UIScreen mainScreen].bounds.size.width - mArray.count * subview_width) / (mArray.count + 1);
//    [mArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:subview_width leadSpacing:padding_honrizental tailSpacing:padding_honrizental];
//    [mArray mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).offset(100);
//        make.height.equalTo(@(subview_height));
//    }];

    [mArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [mArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.height.equalTo(@(100));
    }];
}

@end
