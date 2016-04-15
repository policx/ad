//
//  AlertDemoViewController.m
//  ad
//
//  Created by policx on 16/4/7.
//  Copyright © 2016年 policx. All rights reserved.
//

#import "AlertDemoViewController.h"
@interface AlertDemoViewController ()
@property(nonatomic,strong) UIWebView *webBlog;
@end

@implementation AlertDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"江湖";
    self.webBlog = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    NSString * path = @"http://www.policx.com";
    NSURL *webURL = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:webURL];
    //设置缩放
    [self.webBlog setScalesPageToFit:YES];
    [self.webBlog loadRequest:request];
    [self.view addSubview:_webBlog];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
