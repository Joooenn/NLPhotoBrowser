//
//  NLBrowserViewModel.h
//  NLPhotoBrowser
//
//  Created by liangzc on 2017/6/29.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NLBrowserViewModel : NSObject

+ (NSArray *)urls;
+ (NSArray *)createPhotoModels:(NSArray*)photos;
@end
