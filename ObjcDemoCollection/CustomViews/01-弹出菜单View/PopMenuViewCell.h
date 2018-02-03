//
//  PopMenuViewCell.h
//  CustomPopMenuView
//
//  Created by jiabaozhang on 17/4/10.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PopMenuItem;

@interface PopMenuViewCell : UITableViewCell

- (void)updatePopMenuItem:(PopMenuItem *)item;
- (void)bottomLineShouldHide:(BOOL)shouldHide;

@end
