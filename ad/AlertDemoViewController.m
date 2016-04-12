//
//  AlertDemoViewController.m
//  ad
//
//  Created by policx on 16/4/7.
//  Copyright © 2016年 policx. All rights reserved.
//

#import "AlertDemoViewController.h"
#import "CCWebViewController.h"
@interface AlertDemoViewController ()
@end

@implementation AlertDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString * path = @"http://www.policx.com";
    [CCWebViewController showWithContro:self withUrlStr:path withTitle:@"江湖"];
    
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
