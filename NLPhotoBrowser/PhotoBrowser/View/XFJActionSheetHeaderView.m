//
//  XFJActionSheetHeaderView.m
//  xfj
//
//  Created by xlb_liangzc on 16/11/11.
//  Copyright © 2016年 xlbyun. All rights reserved.
//

#import "XFJActionSheetHeaderView.h"
#import "Masonry.h"

@implementation XFJActionSheetHeaderView

- (instancetype)initWithFrame:(CGRect)frame
                  headerTitle:(NSString *)title
                  headerImage:(UIImage *)image {
    
    self = [super initWithFrame:frame];
    if (self) {
        //title
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.text = title;
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        //image
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.image = image;
        [self addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(titleLabel);
            make.trailing.equalTo(titleLabel.mas_leading).offset(-20);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
    }
    return self;
}

#pragma mark - Draw
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
