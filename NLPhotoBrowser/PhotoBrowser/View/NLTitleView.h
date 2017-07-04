//
//  NLTitleView.h
//  NLPhotoBrowser
//
//  Created by liangzc on 2017/7/3.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NLTitleStyle) {
    NLTitleStyleSingle = 0,
    NLTitleStyleDouble
};

@interface NLTitleView : UIView

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)anItems;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger page;
@end
