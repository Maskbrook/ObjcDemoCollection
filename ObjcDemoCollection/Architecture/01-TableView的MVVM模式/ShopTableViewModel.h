//
//  ShopTableViewModel.h
//  ObjcDemoCollection
//
//  Created by 张家宝 on 2018/2/4.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ShopData;

typedef void(^SelectCellBlock)(NSIndexPath *path, ShopData *data); // 选中cell的block
typedef CGFloat(^SetCellHeightBlock)(void); // set cell height

@interface ShopTableViewModel : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) SelectCellBlock selectCellBlock;
@property (nonatomic, copy) SetCellHeightBlock setCellHeightBlock;

- (void)configureDatasourceAndDelegateForTableView:(UITableView *)tableView;

@end
