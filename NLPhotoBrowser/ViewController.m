//
//  ViewController.m
//  NLPhotoBrowser
//
//  Created by liangzc on 2017/6/29.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import "ViewController.h"
#import "NLPhotoBrowserViewController.h"
#import "NLBrowserViewModel.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;
@end

static NSString * const kCellReuseIdentifier = @"Cell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"PhotoBrowser";
    self.dataArray = @[@"web photo"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *urls = @[@"http://upload-images.jianshu.io/upload_images/5350321-ae065c1e5f8ce2d1.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                      @"http://upload-images.jianshu.io/upload_images/3247999-08fc131e165a0855.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                      @"http://upload-images.jianshu.io/upload_images/3247999-ae96f97413c450da.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                      @"http://upload-images.jianshu.io/upload_images/4336008-3da38a32adee02f2.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                      @"http://upload-images.jianshu.io/upload_images/4336008-c89e36f0ab50c5fd.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
    
    NLPhotoBrowserViewController *photoBrowser = [[NLPhotoBrowserViewController alloc] initWithItems:urls describ:@"你拥有了一个 GitHub 账号之后，就可以自由的 clone 或者下载其他项目，也可以创建自己的项目，但是你没法提交代码。仔细想想也知道，肯定不可能随意就能提交代码的"];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self.navigationController pushViewController:photoBrowser animated:YES];
}


@end
