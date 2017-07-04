//
//  NLPhotoCell.m
//  NLPhotoBrowser
//
//  Created by liangzc on 2017/6/29.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import "NLPhotoCell.h"
#import <UIImageView+YYWebImage.h>
#import <Masonry.h>
#import "UIView+Frame.h"
#import "NLMacro.h"
#import "NLPhotoModel.h"


@interface NLPhotoCell () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView  *imageView;
@property (nonatomic, strong) UIView *describBaseView;
@property (nonatomic, strong) UILabel *describLabel;

@end

@implementation NLPhotoCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - private
- (void)setupViews {
    
    [self.contentView addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [self.scrollView addGestureRecognizer:singleTap];
    [self.scrollView addGestureRecognizer:doubleTap];
}

- (void)singleTap:(UITapGestureRecognizer *)singleTap {
    if ([self.delegate respondsToSelector:@selector(singleTap)]) {
        [self.delegate singleTap];
    }
}

- (void)doubleTap:(UITapGestureRecognizer *)doubleTap {
    if (self.scrollView.zoomScale > 1) {
        [self.scrollView setZoomScale:1 animated:YES];
    } else {
        CGPoint touchPoint = [doubleTap locationInView:self.imageView];
        CGFloat newZoomScale = self.scrollView.maximumZoomScale;
        CGFloat xsize = self.width / newZoomScale;
        CGFloat ysize = self.height / newZoomScale;
        [self.scrollView zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
    }
}

- (void)resizesSubViews {
    
    UIImage *image = self.imageView.image;
    if (!image) return;
    
    if (image.size.height / image.size.width > self.contentView.height / self.contentView.width) {
        self.imageView.height = floor(image.size.height / (image.size.width / self.imageView.width));
        self.imageView.y = 0;
    } else {
        CGFloat height = image.size.height / image.size.width * self.contentView.width;
        if (height < 1 || isnan(height)) height = self.contentView.height;
        height = floor(height);
        self.imageView.height = height;
        self.imageView.centerY = self.contentView.height / 2;
    }
    if (self.imageView.height > self.height && self.imageView.height - self.contentView.height <= 1) {
        self.imageView.height = self.height;
    }
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, MAX(self.imageView.height, self.contentView.height));
    [_scrollView scrollRectToVisible:_scrollView.bounds animated:NO];
    if (self.imageView.height <= self.contentView.height) {
        _scrollView.alwaysBounceVertical = NO;
    } else {
        _scrollView.alwaysBounceVertical = YES;
    }
    
}

#pragma mark - overwrite
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

-(void)pinchAction:(UIPinchGestureRecognizer *)pinch {
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pinch.scale, pinch.scale);
    pinch.scale = 1;
}

#pragma mark - getter & setter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor blackColor];
        _scrollView.delegate = self;
    }
    return _scrollView;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

- (void)setPhoto:(NLPhotoModel *)photo {
    
    if (_photo == photo) return;
    _photo = photo;
    
    [self.scrollView setZoomScale:1. animated:NO];
    self.scrollView.maximumZoomScale = 1;
    
    [self.imageView yy_setImageWithURL:[NSURL URLWithString:photo.imageUrl] placeholder:nil options:YYWebImageOptionProgressive completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (!error) {
            self.scrollView.maximumZoomScale = 3;
            [self resizesSubViews];
        }
    }];
    [self resizesSubViews];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                         scrollView.contentSize.height * 0.5 + offsetY);
}

#pragma mark - NLBottomToolbarDelegate
- (void)toolbarDidClickLikeButton {
    
}

@end
