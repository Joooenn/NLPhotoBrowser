//
//  NLDescribBaseView.h
//  NLPhotoBrowser
//
//  Created by liangzc on 2017/6/30.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NLDescribBaseView : UIView

@property (nonatomic, copy) NSString *describ;

- (instancetype)initWithDescrib:(NSString *)describ;
- (instancetype)init;
@end
