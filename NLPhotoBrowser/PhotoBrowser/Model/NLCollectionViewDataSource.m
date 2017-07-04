//
//  CollectionViewDataSource.m
//  NLPhotoBrowser
//
//  Created by liangzc on 2017/6/29.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import "NLCollectionViewDataSource.h"

@interface NLCollectionViewDataSource ()

@property (nonatomic, copy) NSString *cellReuseIdentifier;
@property (nonatomic, copy) CollectionViewCellConfigure configureCellBlock;
@end

@implementation NLCollectionViewDataSource

#pragma init
- (instancetype)initWithItems:(NSArray *)anItems
          cellReuseIdentifier:(NSString *)cellReuseIdentifier
           configureCellBlock:(CollectionViewCellConfigure)configureCellBlock {
    self = [super init];
    if (self) {
        _items = anItems;
        _cellReuseIdentifier = cellReuseIdentifier;
        _configureCellBlock = [configureCellBlock copy];
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.items.count == 0) {
        return nil;
    }
    return self.items[indexPath.row];
}

#pragma mark - Delegate & DataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellReuseIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    
    return cell;
}

@end
