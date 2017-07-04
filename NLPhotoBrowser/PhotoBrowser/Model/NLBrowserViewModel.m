//
//  NLBrowserViewModel.m
//  NLPhotoBrowser
//
//  Created by liangzc on 2017/6/29.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import "NLBrowserViewModel.h"
#import "NLMacro.h"
#import "NLPhotoModel.h"

@implementation NLBrowserViewModel

+ (NSArray *)createPhotoModels:(NSArray*)photos {
    NSMutableArray *temp = [NSMutableArray new];
    for (NSString *urlString in photos) {
        NLPhotoModel *model = [NLPhotoModel new];
        model.imageUrl = urlString;
        [temp addObject:model];
    }
    return temp.copy;
}

+ (NSArray *)urls {
    return @[@"http://upload-images.jianshu.io/upload_images/5350321-ae065c1e5f8ce2d1.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
             @"http://upload-images.jianshu.io/upload_images/3247999-08fc131e165a0855.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
             @"http://upload-images.jianshu.io/upload_images/3247999-ae96f97413c450da.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
             @"http://upload-images.jianshu.io/upload_images/4336008-3da38a32adee02f2.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
             @"http://upload-images.jianshu.io/upload_images/4336008-c89e36f0ab50c5fd.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
}

@end
