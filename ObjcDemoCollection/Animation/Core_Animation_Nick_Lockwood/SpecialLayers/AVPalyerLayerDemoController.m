//
//  AVPalyerLayerDemoController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/1/22.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "AVPalyerLayerDemoController.h"
#import <AVFoundation/AVFoundation.h>

@interface AVPalyerLayerDemoController ()

@end

@implementation AVPalyerLayerDemoController
{
    UIView *_playerView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _playerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    _playerView.center = self.view.center;
    [self.view addSubview:_playerView];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Ship" withExtension:@"mp4"];
    
    //create player and player layer
    AVPlayer *player = [AVPlayer playerWithURL:url];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    //set player layer frame and attach it to our view
    playerLayer.frame = _playerView.bounds;
    [_playerView.layer addSublayer:playerLayer];
    
    //transform layer
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 1, 1, 1);
    playerLayer.transform = transform;
    
    //add rounded corners and border
    playerLayer.masksToBounds = YES;
    playerLayer.cornerRadius = 25.0;
    playerLayer.borderColor = [UIColor blackColor].CGColor;
    playerLayer.borderWidth = 8.0;
    
    //play the video
    [player play];
}

@end
