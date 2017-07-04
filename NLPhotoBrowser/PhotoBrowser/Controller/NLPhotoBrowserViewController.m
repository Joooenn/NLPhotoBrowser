//
//  NLPhotoBrowserViewController.m
//  NLPhotoBrowser
//
//  Created by liangzc on 2017/6/29.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import "NLPhotoBrowserViewController.h"
#import "NLMacro.h"
#import "NLCollectionViewDataSource.h"
#import "NLPhotoCell.h"
#import "NLPhotoModel.h"
#import "NLBrowserViewModel.h"
#import "UINavigationBar+Awesome.h"
#import "NLBottomToolbar.h"
#import <Masonry.h>
#import "NLDescribBaseView.h"
#import "NLUtils.h"
#import "UIView+Frame.h"
#import "NLTitleView.h"
#import "XFJActionSheetView.h"

@interface NLPhotoBrowserViewController () <UICollectionViewDelegate, NLBottomToolbarDelegate, NLPhotoCellDelegate>

@property (nonatomic, strong) NLTitleView *cusTitleView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NLBottomToolbar *toolbar;
@property (nonatomic, strong) NLDescribBaseView *describView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NLCollectionViewDataSource *dataSource;
@property (nonatomic, copy) NSArray *photos;
@property (nonatomic, copy) NSString *describ;
@end

static NSString * const kPhotoCellReuseIdentifier = @"NLPhotoCell";
static CGFloat const kToolbarHeight = 50.0;
static CGFloat const kMaxDescribViewHeight = 80.0;

@implementation NLPhotoBrowserViewController

- (instancetype)initWithItems:(NSArray *)anItems {
    self = [super init];
    if (self == nil) return nil;
    _photos = anItems;
    return self;
}
- (instancetype)initWithItems:(NSArray *)anItems describ:(NSString *)describ {
    self = [super init];
    if (self == nil) return nil;
    _photos = anItems;
    _describ = describ;
    return self;
}
- (instancetype)initWithItems:(NSArray *)anItems describ:(NSString *)describ selectPage:(NSInteger)page {
    self = [super init];
    if (self == nil) return nil;
    _photos = anItems;
    _describ = describ;
    _page = page;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViews];
    [self loadPhotos];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.page inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar lt_setBackgroundColor: NLRGB16Color(0x80d4a0)];
}

- (void)setupViews {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.collectionView];
    
    CollectionViewCellConfigure cellConfigure = ^(NLPhotoCell *cell, NLPhotoModel *photo){
        cell.photo = photo;
        cell.delegate = self;
    };
    self.dataSource = [[NLCollectionViewDataSource alloc] initWithItems:self.photos cellReuseIdentifier:kPhotoCellReuseIdentifier configureCellBlock:cellConfigure];
    self.collectionView.dataSource = self.dataSource;
    
    [self.view addSubview:self.toolbar];
    [self.view addSubview:self.describView];
    
    self.navigationItem.titleView = self.cusTitleView;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_more"] style:UIBarButtonItemStylePlain target:self action:@selector(moreAction)];;
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar lt_setBackgroundColor: [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(self.view);
        make.height.mas_equalTo(kToolbarHeight);
    }];
    [self.describView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.toolbar.mas_top);
        make.height.mas_equalTo(self.describView.height > 0 ? self.describView.height : kMaxDescribViewHeight);
    }];
}

- (void)loadPhotos {
    
    self.dataSource.items = self.photos;
    self.describView.describ = self.describ;
    self.describView.height = [NLUtils fetchHeightWithText:self.describView.describ font:[UIFont systemFontOfSize:14]] + kSpacing;
    [self.collectionView reloadData];
}

- (void)moreAction {
    
    NSArray *items = @[@"发送给朋友",@"收藏",@"保存图片"];
    XFJActionSheetView *sheetView = [[XFJActionSheetView alloc] initWithItems:items didSelectRowBlock:^(NSUInteger index) {
        
    }];
    [sheetView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter
static CGFloat const kSpacing = 8.0;
- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 2 * kSpacing;
        _flowLayout.minimumInteritemSpacing = 2 * kSpacing;
        _flowLayout.itemSize = self.view.frame.size;
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, kSpacing, 0, kSpacing);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(-kSpacing, 0, self.view.frame.size.width + 2 * kSpacing, self.view.frame.size.height) collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor blackColor];
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[NLPhotoCell class] forCellWithReuseIdentifier:kPhotoCellReuseIdentifier];
    }
    return _collectionView;
}
- (NLBottomToolbar *)toolbar {
    if (!_toolbar) {
        _toolbar = [[NLBottomToolbar alloc] init];
        _toolbar.delegate = self;
    }
    return _toolbar;
}
- (NLDescribBaseView *)describView {
    if (!_describView) {
        _describView = [[NLDescribBaseView alloc] init];
    }
    return _describView;
}
- (NLTitleView *)cusTitleView {
    if (!_cusTitleView) {
        _cusTitleView = [[NLTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 170.0, 44) items:self.photos];
        _cusTitleView.page = self.page;
    }
    return _cusTitleView;
}


#pragma mark - NLBottomToolbarDelegate
- (void)toolbarDidClickLikeButton {
    NSLog(@"赞了一下");
}

#pragma mark - NLPhotoCellDelegate
- (void)singleTap {
    
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBar.isHidden animated:YES];
    
    if (!self.toolbar.isHidden) {
        [UIView animateWithDuration:.25 animations:^{
            self.toolbar.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, [UIScreen mainScreen].bounds.size.height - CGRectGetMinY(self.toolbar.frame));
            self.describView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, CGRectGetHeight(self.toolbar.frame));
        } completion:^(BOOL finished) {
            self.toolbar.hidden = YES;
        }];
    }else {
        self.toolbar.hidden = NO;
        [UIView animateWithDuration:.25 animations:^{
            self.toolbar.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
            self.describView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
        } completion:^(BOOL finished) {
            
        }];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.page = (scrollView.contentOffset.x + (SCREEN_WIDTH + 16)/2) / (SCREEN_WIDTH + 16);
    self.cusTitleView.page = self.page;
}


@end
