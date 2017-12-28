//
//  CubeFaceDemoController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2017/12/28.
//  Copyright © 2017年 jiabaozhang. All rights reserved.
//

#import "CubeFaceDemoController.h"

@interface CubeFaceDemoController ()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation CubeFaceDemoController

#pragma mark - life cycle methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupCubefaceView];
}


#pragma mark - private methods
- (void)setupCubefaceView
{
    // create container view
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.containerView.backgroundColor = [UIColor redColor];
    self.containerView.center = self.view.center;
    CATransform3D perspective = CATransform3DIdentity;
    perspective = CATransform3DRotate(perspective, M_PI_4, 0, 1, 0);
    perspective.m34 = -1.0 / 500;
    [self.view addSubview:self.containerView];
    
    // add cube face 1
    UIView *face1 = [[UIView alloc] initWithFrame:self.containerView.bounds];
    face1.backgroundColor = [UIColor greenColor];
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 100);
    [self addFace:face1 withTransform:transform];
    
    //add cube face 2
    UIView *face2 = [[UIView alloc] initWithFrame:self.containerView.bounds];
    face2.backgroundColor = [UIColor magentaColor];
    transform = CATransform3DMakeTranslation(100, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:face2 withTransform:transform];
}

- (void)addFace:(UIView *)faceView withTransform:(CATransform3D)transform
{
    [self.containerView addSubview:faceView];
    //center the face view within the container
    CGSize containerSize = self.containerView.bounds.size;
    faceView.center = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    // apply the transform
    faceView.layer.transform = transform;
}

@end
