//
//  AppDelegate.m
//  ad
//
//  Created by policx on 16/4/7.
//  Copyright © 2016年 policx. All rights reserved.
//

#import "AppDelegate.h"
#import "AlertDemoViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    AlertDemoViewController *vc = [[AlertDemoViewController alloc]init];
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    
    if (([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8)) {
        [navi.navigationBar setBarTintColor:[UIColor clearColor]];
    }else{
        [navi.navigationBar setTintColor:[UIColor clearColor]];
    }
    self.rootNavi = navi;
    self.window.rootViewController = navi;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    [self startAd];
    
    
    
    return YES;
}

// 启动广告
- (void)startAd {
    // 广告图
    self.adImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [self.adImageView setImage:[UIImage imageNamed:@"太阳"]];
    [self.rootNavi.view addSubview:self.adImageView];
    
    
    // 倒计时按钮
    self.timeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.timeButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width -100, 70, 50, 30);
    _timeButton.titleLabel.font    = [UIFont systemFontOfSize: 20];
    
    //给按钮加一个白色的板框
    self.timeButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.timeButton.layer.borderWidth = 1.0f;
    
    //给按钮设置弧度,这里将按钮变成了圆形
    self.timeButton.layer.cornerRadius = 5.0f;
    self.timeButton.backgroundColor = [UIColor clearColor];
    self.timeButton.layer.masksToBounds = YES;
    [self.adImageView addSubview:self.timeButton];
    
    //倒计时方法
    [self startTime];
    
    [self performSelector:@selector(removeAdImageView) withObject:nil afterDelay:3];
}

- (void)removeAdImageView
{
    
    [UIView animateWithDuration:2.5f animations:^{
        self.adImageView.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        self.adImageView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.adImageView removeFromSuperview];
        self.window.rootViewController = self.rootNavi;
    }];
}
//倒计时方法
-(void)startTime{
    __block int timeout=3; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                _timeButton.userInteractionEnabled = YES;
                [_timeButton removeFromSuperview];
            });
        }else{
            int seconds = timeout % 5;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_timeButton setTintColor:[UIColor whiteColor]];
                [_timeButton setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
