//
//  CircleView.h
//  CircleAnimation
//
//  Created by fujin on 15/10/19.
//  Copyright © 2015年 fujin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView
/**
 *  加入对应值的圆弧
 *
 *  @param percent       (0-100)
 *  @param animationTime 动画时间
 */
-(void)makeCircle:(NSInteger)percent withAnimationTime:(CGFloat)animationTime;
/**
 *  恢复原位置
 */
-(void)clearCircles;
@end
