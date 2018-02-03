//
//  ScrollingBarCollectionLayout.m
//  ObjectiveCSummmaryDemo
//
//  Created by jiabaozhang on 17/5/17.
//  Copyright © 2017年 PPTV聚力. All rights reserved.
//

#import "ScrollingBarCollectionLayout.h"

@implementation ScrollingBarCollectionLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    
    if (self.collectionView.bounds.size.height) {
        self.itemSize = self.collectionView.bounds.size;
    }
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

@end
