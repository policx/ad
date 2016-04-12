//
//  PoAd.m
//  ad
//
//  Created by policx on 16/4/11.
//  Copyright © 2016年 policx. All rights reserved.
//

#import "PoAd.h"

@implementation PoAd

- (void)initStartAd:(UIView *)adView{
    self.adImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [self.adImageView setImage:[UIImage imageNamed:@"太阳"]];
    [adView addSubview:self.adImageView];
    // 加载进度
    [self loadProgress];
}
-(void)startAd {
    // 广告图
    self.adImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [self.adImageView setImage:[UIImage imageNamed:@"太阳"]];
    //[self addSubview:self.adImageView];
    // 加载进度
    [self loadProgress];
    
    // [self performSelector:@selector(removeAdImageView) withObject:nil afterDelay:3];
}
// 加载进度
- (void)loadProgress {
    self.circleAniView = [[CircleAnimationView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width -70, 70, 35, 35)];
    //self.circleAniView.center = self.view.center;
    self.circleAniView.backgroundColor = [UIColor clearColor];
    [self.adImageView addSubview:self.circleAniView];
    
    self.circleAniView.percentStr = @"100";
    
    // 跳过按钮
    self.timeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.timeButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width -100, 70, 50, 30);
    //_timeButton.titleLabel.font    = [UIFont systemFontOfSize: 20];
    
    ////给按钮加一个白色的板框
    //self.timeButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    //self.timeButton.layer.borderWidth = 1.0f;
    
    ////给按钮设置弧度,这里将按钮变成了圆形
    //self.timeButton.layer.cornerRadius = 5.0f;
    //self.timeButton.backgroundColor = [UIColor clearColor];
    //self.timeButton.layer.masksToBounds = YES;
    //[self.rootNavi.view addSubview:self.timeButton];
    [_timeButton addTarget:self action:@selector(removeAdImageView) forControlEvents:UIControlEventTouchUpInside];
    
    //倒计时方法
    [self startTime];
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
                [_circleAniView removeFromSuperview];
                [self removeAdImageView];
            });
        }else{
            //int seconds = timeout % 5;
            //NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //[_timeButton setTintColor:[UIColor whiteColor]];
                //[_timeButton setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

// 删除视图
- (void)removeAdImageView
{
    NSLog(@"NB");
    [UIView animateWithDuration:0.5f animations:^{
        self.adImageView.transform = CGAffineTransformMakeScale(0.8f, 0.8f);
        self.adImageView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.adImageView removeFromSuperview];
        //self.window.rootViewController = self.rootNavi;
    }];
}
@end
