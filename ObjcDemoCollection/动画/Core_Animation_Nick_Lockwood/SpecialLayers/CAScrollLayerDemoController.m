//
//  CAScrollLayerDemoController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/1/18.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "CAScrollLayerDemoController.h"

@interface CAScrollLayerDemoController ()

@property (nonatomic, strong) CAScrollLayer *scrollLayer;

@end

@implementation CAScrollLayerDemoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"Sprites"];
    CALayer *layer = [CALayer layer];
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsGravity = kCAGravityCenter;
    layer.contentsScale = image.scale;
    layer.frame = CGRectMake(20, 20, 100, 100);
    
    self.scrollLayer = [CAScrollLayer layer];
    self.scrollLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    self.scrollLayer.frame = CGRectMake(100, 100, 200, 200);
    [self.scrollLayer addSublayer:layer];
    
    self.scrollLayer.scrollMode = kCAScrollBoth;
    [self.view.layer addSublayer:self.scrollLayer];
    
    // add gesture
    UIPanGestureRecognizer *recognizer = nil;
    recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:recognizer];
}

- (void)pan:(UIPanGestureRecognizer *)recognizer
{
    //get the offset by subtracting the pan gesture
    //translation from the current bounds origin
//    CGPoint offset = self.view.bounds.origin;
//    offset.x -= [recognizer translationInView:self.view].x;
//    offset.y -= [recognizer translationInView:self.view].y;
    
    CGPoint translation = [recognizer translationInView:self.view];
    CGPoint origin = self.scrollLayer.bounds.origin;
    origin = CGPointMake(origin.x-translation.x, origin.y-translation.y);
    
    //scroll the layer
    [self.scrollLayer scrollToPoint:origin];
    
    //reset the pan gesture translation
    [recognizer setTranslation:CGPointZero inView:self.view];
}

@end
