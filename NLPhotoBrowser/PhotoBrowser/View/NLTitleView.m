//
//  NLTitleView.m
//  NLPhotoBrowser
//
//  Created by liangzc on 2017/7/3.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import "NLTitleView.h"
#import <Masonry.h>
#import "UIView+Frame.h"

@interface NLTitleView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, assign) NLTitleStyle titleStyle;
@property (nonatomic, copy) NSArray *items;
@end

static CGFloat const kTitleFontSize = 15.0;
static CGFloat const kSubTitleFontSize = 14.0;

@implementation NLTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init {
    self = [super init];
    if (self == nil) return nil;
    [self setupViews];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)anItems {
    self = [super initWithFrame:frame];
    if (self == nil) return nil;
    _titleStyle = anItems.count > 1 ? NLTitleStyleDouble : NLTitleStyleDouble;
    _items = anItems;
    [self setupViews];
    return self;
}

- (void)setupViews {
    
    [self addSubview:self.titleLabel];
    if (self.titleStyle != NLTitleStyleSingle) {
        [self addSubview:self.subTitleLabel];
    }
}

#pragma mark - overwrite
- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.titleStyle == NLTitleStyleSingle) {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    } else {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.trailing.equalTo(self);
            make.height.equalTo(self.subTitleLabel.mas_height);
        }];
        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.bottom.trailing.equalTo(self);
            make.height.equalTo(self.titleLabel.mas_height);
            make.top.equalTo(self.titleLabel.mas_bottom);
        }];
    }
}

#pragma mark - getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.textColor = [UIColor whiteColor];
        _subTitleLabel.font = [UIFont systemFontOfSize:kSubTitleFontSize];
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _subTitleLabel;
}

#pragma mark - setter
- (void)setPage:(NSInteger)page {
    _page = page;
    self.titleLabel.text = @"2017年7月3日 5:30";
    self.subTitleLabel.text = [NSString stringWithFormat:@"%ld/%ld",page + 1, self.items.count];
}


@end
