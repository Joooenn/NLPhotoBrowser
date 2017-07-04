//
//  NLBaseViewController.m
//  NLPhotoBrowser
//
//  Created by liangzc on 2017/6/30.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import "NLBaseViewController.h"
#import "NLMacro.h"

@interface NLBaseViewController ()

@end

@implementation NLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    DLog(@"+++++++++++++++++%@ 被释放了+++++++++++++++++", NSStringFromClass([self class]))
}

//设置status bar样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
