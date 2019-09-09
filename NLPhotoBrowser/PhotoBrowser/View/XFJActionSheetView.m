//
//  XFJCategoryView.m
//  xfj
//
//  Created by ZhangJing on 16/8/22.
//  Copyright © 2016年 xlbyun. All rights reserved.
//

#import "XFJActionSheetView.h"


static CGFloat const kXFJCategroyCellHeight = 50.0;
static CGFloat const kXFJCategroyHeaderViewHeight = 5.0;
static NSTimeInterval const kAnimationDuration = 0.3;

@interface XFJActionSheetView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSString *> *items;
@property (nonatomic, copy) XFJCategoryViewDidSelectRowBlock didSelectRowBlock;

@end

@implementation XFJActionSheetView {
    BOOL _isShow;
    CGRect _tableViewHideFrame;
    CGRect _tableViewShowFrame;
}

- (instancetype)initWithItems:(NSArray<NSString *> *)anItems didSelectRowBlock:(XFJCategoryViewDidSelectRowBlock) aBlock
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.didSelectRowBlock = aBlock;
        self.items = anItems;
        [self p_commonSetup];
    }
    return self;
}

- (void)p_commonSetup {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
    CGFloat tableViewHeight = [self getTableViewHeight];
    _tableViewHideFrame = CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), tableViewHeight);
    _tableViewShowFrame = CGRectMake(0, CGRectGetHeight(self.bounds) - tableViewHeight, CGRectGetWidth(self.bounds), tableViewHeight);
    [self addSubview:self.tableView];
    self.tableView.frame = _tableViewHideFrame;
}

- (CGFloat)getTableViewHeight {
    return self.items.count * kXFJCategroyCellHeight + kXFJCategroyHeaderViewHeight + kXFJCategroyCellHeight;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hide];
}

- (void)show {
//    self.alpha = 0.0;
    if (![[UIApplication sharedApplication].keyWindow.subviews containsObject:self]) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
//        self.alpha = 1.0;
        self.tableView.frame = _tableViewShowFrame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    [UIView animateWithDuration:kAnimationDuration animations:^{
//        self.alpha = 0.0;
        self.tableView.frame = _tableViewHideFrame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? self.items.count : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0 : kXFJCategroyHeaderViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), kXFJCategroyHeaderViewHeight)];
    view.backgroundColor = self.tableView.separatorColor;
    return view;
}

static NSString *const kXFJCategoryViewCellIdentifier = @"XFJCategoryViewCell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kXFJCategoryViewCellIdentifier forIndexPath:indexPath];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = self.items[indexPath.row];
    } else {
        cell.textLabel.text = @"取消";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (self.didSelectRowBlock) {
            self.didSelectRowBlock(indexPath.row);
        }
    } else {
        if (indexPath.row==2) {
            if (self.didSelectRowBlock) {
                self.didSelectRowBlock(indexPath.row);
            }
        }
    }
    [self hide];
}

#pragma mark - getter & setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.alwaysBounceVertical = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.rowHeight = kXFJCategroyCellHeight;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kXFJCategoryViewCellIdentifier];
    }
    return _tableView;
}

@end
