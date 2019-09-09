//
//  NLPhotoCell.h
//  NLPhotoBrowser
//
//  Created by liangzc on 2017/6/29.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NLPhotoCellDelegate <NSObject>

- (void)singleTap;
@end

@class NLPhotoModel;

@interface NLPhotoCell : UICollectionViewCell

@property (nonatomic, assign) id<NLPhotoCellDelegate> delegate;
@property (nonatomic, strong) NLPhotoModel *photo;

@property (nonatomic, strong) UIImageView  *imageView;

@property (nonatomic, assign) BOOL hasLoadImage;
@end
