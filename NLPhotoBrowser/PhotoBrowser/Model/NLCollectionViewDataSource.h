//
//  CollectionViewDataSource.h
//  NLPhotoBrowser
//
//  Created by liangzc on 2017/6/29.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^CollectionViewCellConfigure)(id cell, id item);

@interface NLCollectionViewDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *items;

- (instancetype)initWithItems:(NSArray *)anItems
          cellReuseIdentifier:(NSString *)cellReuseIdentifier
           configureCellBlock:(CollectionViewCellConfigure)configureCellBlock;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
