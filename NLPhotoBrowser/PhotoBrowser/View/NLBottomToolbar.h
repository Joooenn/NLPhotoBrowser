//
//  NLBottomToolbar.h
//  NLPhotoBrowser
//
//  Created by liangzc on 2017/6/30.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NLBaseButton : UIButton

@end

@interface NLBaseLabel : UILabel

@end

@protocol NLBottomToolbarDelegate <NSObject>

- (void)toolbarDidClickLikeButton;
@end

@interface NLBottomToolbar : UIView

@property (nonatomic, assign) id<NLBottomToolbarDelegate> delegate;
- (instancetype)init;
@end
