//
//  NLDescribBaseView.m
//  NLPhotoBrowser
//
//  Created by liangzc on 2017/6/30.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import "NLDescribBaseView.h"
#import <CoreText/CoreText.h>
#import "NLMacro.h"
#import "NLUtils.h"

#define TEXT_FONT_NAME @"PingFangSC"
#define TEXT_FONT_SIZE 14.0

static CGFloat const kSpacing = 5.0;

@interface NLDescribBaseView ()

@end

@implementation NLDescribBaseView {
    CATextLayer *_textLayer;
    NSString *_describ;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
static CATextLayer *text_layer(CGFloat contentScale, CTFontRef font, NSString *text) {
    CATextLayer *layer = [CATextLayer layer];
    layer.font = font;
    layer.fontSize = TEXT_FONT_SIZE;
    layer.string = text;
    layer.contentsScale = contentScale;
    layer.wrapped = YES;
    layer.alignmentMode = kCAAlignmentLeft;
    return layer;
}

- (instancetype)init {
    self = [super init];
    if (self == nil) return nil;
    
    [self setupLayers];
    return self;
}
- (instancetype)initWithDescrib:(NSString *)describ {
    self = [super init];
    if (self == nil) return nil;
    
    _describ = describ;
    [self setupLayers];
    return self;
}

- (void)setupLayers {
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    CGFloat contentsScale = [UIScreen mainScreen].scale;
    CTFontRef font = CTFontCreateWithName((CFStringRef)TEXT_FONT_NAME, TEXT_FONT_SIZE, NULL);
    _textLayer = text_layer(contentsScale, font, _describ);
    _textLayer.foregroundColor = [UIColor whiteColor].CGColor;
    _textLayer.backgroundColor = [UIColor clearColor].CGColor;
    _textLayer.bounds = CGRectMake(-kSpacing, -kSpacing, SCREEN_WIDTH-2*kSpacing, [NLUtils fetchHeightWithText:_describ font:[UIFont fontWithName:TEXT_FONT_NAME size:TEXT_FONT_SIZE]]);
    CGRect bounds = _textLayer.bounds;
    _textLayer.position = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    
    [self.layer addSublayer:_textLayer];
}

- (void)layoutTextLayer {
    CGRect bounds = self.bounds;
    CGPoint center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    _textLayer.bounds = CGRectMake(-kSpacing, -kSpacing, SCREEN_WIDTH-2*kSpacing, [NLUtils fetchHeightWithText:_describ font:[UIFont fontWithName:TEXT_FONT_NAME size:TEXT_FONT_SIZE]]);
    _textLayer.position = center;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self layoutTextLayer];
}

#pragma mark - setter
- (void)setDescrib:(NSString *)describ {
    _describ = describ;
    
    _textLayer.string = describ;
}



@end
