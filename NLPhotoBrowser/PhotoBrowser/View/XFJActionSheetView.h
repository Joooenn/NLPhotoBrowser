//
//  XFJCategoryView.h
//  xfj
//
//  Created by ZhangJing on 16/8/22.
//  Copyright © 2016年 xlbyun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XFJCategoryViewDidSelectRowBlock)(NSUInteger index);
@interface XFJActionSheetView : UIView

@property (nonatomic, strong) UIView *headerView;
- (instancetype)initWithItems:(NSArray<NSString *> *)anItems didSelectRowBlock:(XFJCategoryViewDidSelectRowBlock) aBlock;

- (void)show;
- (void)hide;

@end
