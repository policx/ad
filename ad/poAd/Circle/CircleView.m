//
//  CircleView.m
//  CircleAnimation
//
//  Created by fujin on 15/10/19.
//  Copyright © 2015年 fujin. All rights reserved.
//

#import "CircleView.h"
#define RGBA(r,g,b,a)      [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]

#define pi 3.14159265359
#define DEGREES_DefaultStart(degrees)  ((pi * (degrees+270))/ 180) //默认270度为开始的位置
#define DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)         //转化为度

@interface CircleView ()
@property (nonatomic, assign) CGFloat endDegree;
@property (nonatomic, assign) CGFloat startPercent;
@property (nonatomic, assign) CGFloat endPercent;
@property (nonatomic, strong) CAShapeLayer *animtionLayer;
@property (nonatomic, assign) CGFloat animationTime;
@end

@implementation CircleView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawCircle];
        //默认从零开始
        self.endPercent = 0.0f;
    }
    return self;
}

//初始化
-(void)drawCircle{
    //边缘线
    UIBezierPath *edgePath = [UIBezierPath bezierPath];
    [edgePath addArcWithCenter:CGPointMake(self.frame.size.width*0.5, self.frame.size.height * 0.5) radius:self.frame.size.width * 0.5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    CAShapeLayer *edgeLayer = [CAShapeLayer layer];
    edgeLayer.path = edgePath.CGPath;
    edgeLayer.fillColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5].CGColor;
    edgeLayer.strokeColor = RGBA(240, 240, 240, 1).CGColor;
    edgeLayer.lineWidth = 2;
    edgeLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.layer addSublayer:edgeLayer];
    
}

//加入圆弧layer
-(void)makeCircle:(NSInteger)percent withAnimationTime:(CGFloat)animationTime{
    self.startPercent = self.endPercent;
    self.endPercent = percent/100.0;
    self.animationTime = animationTime;
    
    self.endDegree = DEGREES_DefaultStart(percent/100.0 * 360);
    [self addCircle];
}
-(void)addCircle{
    
    //animtionLayer默认为整个圆圈路径（为了产生动画）
    UIBezierPath *animationPath = [UIBezierPath bezierPath];
    [animationPath addArcWithCenter:CGPointMake(self.frame.size.width*0.5, self.frame.size.height * 0.5) radius:self.frame.size.width * 0.5 startAngle:DEGREES_DefaultStart(0) endAngle:DEGREES_DefaultStart(360) clockwise:YES];

    if(!self.animtionLayer){
        self.animtionLayer = [CAShapeLayer layer];
        self.animtionLayer.fillColor = self.backgroundColor.CGColor;
        self.animtionLayer.strokeColor = [UIColor redColor].CGColor;
        self.animtionLayer.lineWidth = 3;
        self.animtionLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self.layer addSublayer:self.animtionLayer];
    }
    
    self.animtionLayer.path = animationPath.CGPath;
    [self addMakeAnimation:self.animtionLayer];
    
}
//过程动画
-(void)addMakeAnimation:(CAShapeLayer *)shapeLayer{
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = self.animationTime;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:self.endPercent];
    pathAnimation.toValue = [NSNumber numberWithFloat:self.startPercent];
    pathAnimation.autoreverses = NO;
    pathAnimation.delegate = self;
    [shapeLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    //真正的弧形路径
    UIBezierPath *animationPath = [UIBezierPath bezierPath];
    [animationPath addArcWithCenter:CGPointMake(self.frame.size.width*0.5, self.frame.size.height * 0.5) radius:self.frame.size.width * 0.5 startAngle:DEGREES_DefaultStart(0) endAngle:self.endDegree clockwise:YES];
    
    self.animtionLayer.path = animationPath.CGPath;
}

//清除layers
-(void)clearCircles{
    if (!self.animtionLayer) {
        return;
    }
    self.endPercent = 0.0f;
    //清除animtionLayer
    [self.animtionLayer removeFromSuperlayer];
    self.animtionLayer = nil;
}
@end
