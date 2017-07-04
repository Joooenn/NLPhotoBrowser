//
//  NLPhotoBrowserViewController.h
//  NLPhotoBrowser
//
//  Created by liangzc on 2017/6/29.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import "NLBaseViewController.h"

@interface NLPhotoBrowserViewController : NLBaseViewController

@property (nonatomic, assign) NSInteger page;

- (instancetype)initWithItems:(NSArray *)anItems;
- (instancetype)initWithItems:(NSArray *)anItems describ:(NSString *)describ;
- (instancetype)initWithItems:(NSArray *)anItems describ:(NSString *)describ selectPage:(NSInteger)page;
@end
