//
//  SpinnerButton.h
//  ObjcDemoCollection
//
//  Created by 张家宝 on 2018/2/4.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SpinnerLayer;

typedef void(^CompletionBlock)(void);

@interface SpinnerButton : UIButton

@property (nonatomic, strong) SpinnerLayer *spinnerLayer;

- (void)setCompletion:(CompletionBlock)completion;
- (void)startAnimation;
- (void)errorRevertAnimationCompletion:(CompletionBlock)completion;
- (void)exitAnimationCompletion:(CompletionBlock)completion;

@end
