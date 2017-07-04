//
//  NLUtils.m
//  NLPhotoBrowser
//
//  Created by liangzc on 2017/7/3.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import "NLUtils.h"
#import "NLMacro.h"

@implementation NLUtils

+ (CGFloat)fetchHeightWithText:(NSString *)text font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    label.text = text;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    return label.frame.size.height;
}

@end
