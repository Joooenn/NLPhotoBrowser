//
//  NLBottomToolbar.m
//  NLPhotoBrowser
//
//  Created by liangzc on 2017/6/30.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import "NLBottomToolbar.h"
#import <Masonry.h>

static CGFloat const kFontSize = 15.0;

@implementation NLBaseButton
- (instancetype)init {
    self = [super init];
    if (self == nil) return nil;
    self.titleLabel.font = [UIFont systemFontOfSize:kFontSize];
    return self;
}

@end

@implementation NLBaseLabel
- (instancetype)init {
    self = [super init];
    if (self == nil) return nil;
    self.font = [UIFont systemFontOfSize:kFontSize];
    self.textColor = [UIColor whiteColor];
    return self;
}

@end

@interface NLBottomToolbar ()

@property (nonatomic, strong) NLBaseButton *likeButton;
@property (nonatomic, strong) NLBaseButton *reviewButton;
@property (nonatomic, strong) NLBaseLabel *likeLabel;
@property (nonatomic, strong) NLBaseLabel *reviewLabel;
@property (nonatomic, strong) UIImageView *likeImageView;
@property (nonatomic, strong) UIImageView *reviewImageView;
@end

static CGFloat const kSpacing = 8.0;
static CGFloat const kButtonWidth = 50.0;


@implementation NLBottomToolbar

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

- (void)setupViews {
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    [self addSubview:self.likeButton];
    [self addSubview:self.reviewButton];
    [self addSubview:self.reviewLabel];
    [self addSubview:self.reviewImageView];
    [self addSubview:self.likeLabel];
    [self addSubview:self.likeImageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(kButtonWidth);
        make.leading.equalTo(self).offset(2*kSpacing);
    }];
    [self.reviewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self.likeButton.mas_trailing);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(kButtonWidth*1.5);
    }];
    [self.reviewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.trailing.equalTo(self).offset(-2*kSpacing);
    }];
    [self.reviewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.trailing.equalTo(self.reviewLabel.mas_leading).offset(-kSpacing);
    }];
    [self.likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.trailing.equalTo(self.reviewImageView.mas_leading).offset(-kSpacing);
    }];
    [self.likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.trailing.equalTo(self.likeLabel.mas_leading).offset(-kSpacing);
    }];
}

#pragma mark - getter & setter
- (NLBaseButton *)likeButton {
    if (!_likeButton) {
        _likeButton = [[NLBaseButton alloc] init];
        [_likeButton setImage:[UIImage imageNamed:@"icon_like"] forState:UIControlStateNormal];
        [_likeButton setTitle:@"赞" forState:UIControlStateNormal];
        [_likeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_likeButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, kSpacing)];
        [_likeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, kSpacing, 0, 0)];
    }
    return _likeButton;
}
- (NLBaseButton *)reviewButton {
    if (!_reviewButton) {
        _reviewButton = [[NLBaseButton alloc] init];
        [_reviewButton setImage:[UIImage imageNamed:@"icon_review"] forState:UIControlStateNormal];
        [_reviewButton setTitle:@"评论" forState:UIControlStateNormal];
        [_reviewButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_reviewButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, kSpacing)];
        [_reviewButton setTitleEdgeInsets:UIEdgeInsetsMake(0, kSpacing, 0, 0)];
    }
    return _reviewButton;
}
- (NLBaseLabel *)reviewLabel {
    if (!_reviewLabel) {
        _reviewLabel = [[NLBaseLabel alloc] init];
        _reviewLabel.text = @"1";
    }
    return _reviewLabel;
}
- (UIImageView *)reviewImageView {
    if (!_reviewImageView) {
        _reviewImageView = [[UIImageView alloc] init];
        _reviewImageView.image = [UIImage imageNamed:@"icon_review"];
    }
    return _reviewImageView;
}
- (NLBaseLabel *)likeLabel {
    if (!_likeLabel) {
        _likeLabel = [[NLBaseLabel alloc] init];
        _likeLabel.text = @"1";
    }
    return _likeLabel;
}
- (UIImageView *)likeImageView {
    if (!_likeImageView) {
        _likeImageView = [[UIImageView alloc] init];
        _likeImageView.image = [UIImage imageNamed:@"icon_like"];
    }
    return _likeImageView;
}
@end
