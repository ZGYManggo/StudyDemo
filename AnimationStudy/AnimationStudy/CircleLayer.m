//
//  CircleLayer.m
//  AnimationStudy
//
//  Created by jiemo on 16/7/5.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "CircleLayer.h"
#import <UIKit/UIKit.h>
@interface CircleLayer()
@property (strong, nonatomic) UIBezierPath *circleSmallPath;
@property (strong, nonatomic) UIBezierPath *circleBigPath;
@property (strong, nonatomic) UIBezierPath *circleVerticalSquishPath;
@property (strong, nonatomic) UIBezierPath *circleHorizontalSquishPath;
@end
static const NSTimeInterval KAnimationDuration = 0.5;
static const NSTimeInterval KAnimationBeginTime = 0.0;
@implementation CircleLayer
- (instancetype)init {
    
    if (self == [super init]) {
        self.fillColor = [UIColor colorWithRed:0.697 green:0.391 blue:1.000 alpha:1.000].CGColor;
        self.path = self.circleSmallPath.CGPath;
    }
    return self;
}
- (UIBezierPath *)circleSmallPath {
    if (!_circleSmallPath) {
        _circleSmallPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50.0, 50.0, 50.0, 50.0)];
    }
    return _circleSmallPath;
}
- (UIBezierPath *)circleBigPath {
    if (!_circleBigPath) {
        _circleBigPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(2.5, 2.5, 95.0, 95.0)];
    }
    return _circleBigPath;
}
- (UIBezierPath *)circleVerticalSquishPath {
    if (!_circleVerticalSquishPath) {
        _circleVerticalSquishPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(2.5, 5.0, 95.0, 90.0)];
    }
    return _circleVerticalSquishPath;
}
- (UIBezierPath *)circleHorizontalSquishPath{
    if (!_circleHorizontalSquishPath) {
        _circleHorizontalSquishPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(5.0, 5.0, 90, 90)];
    }
    return _circleHorizontalSquishPath;
}
- (void)expand {
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    expandAnimation.fromValue = (__bridge id _Nullable)(self.circleSmallPath.CGPath);
    expandAnimation.toValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    expandAnimation.duration = KAnimationDuration;
    expandAnimation.fillMode = kCAFillModeForwards;
    expandAnimation.removedOnCompletion = NO;
    [self addAnimation:expandAnimation forKey:nil];
    
}
- (void)wobbleAnimation {
    //    1
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation1.fromValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    animation1.toValue = (__bridge id _Nullable)(self.circleVerticalSquishPath.CGPath);
    animation1.beginTime = KAnimationBeginTime;
    animation1.duration = KAnimationDuration;
    //    2
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation2.fromValue = (__bridge id _Nullable)(self.circleVerticalSquishPath.CGPath);
    animation2.toValue = (__bridge id _Nullable)(self.circleHorizontalSquishPath.CGPath);
    animation2.duration = KAnimationDuration;
    animation2.beginTime = animation1.beginTime + animation1.duration;
    //    3
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation3.fromValue = (__bridge id _Nullable)(self.circleHorizontalSquishPath.CGPath);
    animation3.toValue = (__bridge id _Nullable)(self.circleVerticalSquishPath.CGPath);
    animation3.beginTime = animation2.beginTime + animation2.duration;
    animation3.duration = KAnimationDuration;
    //    4
    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation4.fromValue = (__bridge id _Nullable)(self.circleVerticalSquishPath.CGPath);
    animation4.toValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    animation4.beginTime = animation3.beginTime + animation3.duration;
    animation4.duration = KAnimationDuration;

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation1,animation2,animation3,animation4];
    group.duration = KAnimationDuration * 4;
    group.repeatCount = 2;
    [self addAnimation:group forKey:nil];
}

-(void)contract{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    animation.toValue = (__bridge id _Nullable)(self.circleSmallPath.CGPath);
    animation.duration = 0.3;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self addAnimation:animation forKey:nil];
}
@end
