//
//  PoAd.h
//  ad
//
//  Created by policx on 16/4/11.
//  Copyright © 2016年 policx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CircleAnimationView.h"
@interface PoAd : NSObject
@property (nonatomic, strong)CircleAnimationView *circleAniView;
@property (strong, nonatomic) UIImageView *adImageView;
@property(nonatomic,strong) UIButton *timeButton;
- (void)initStartAd:(UIView *)adView webimageStr:(NSString *)imageStr;
@end
