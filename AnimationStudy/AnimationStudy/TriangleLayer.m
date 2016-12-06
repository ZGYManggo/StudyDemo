//
//  TriangleLayer.m
//  AnimationStudy
//
//  Created by jiemo on 16/7/6.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "TriangleLayer.h"
#import <UIKit/UIKit.h>

@interface TriangleLayer ()

@property (strong, nonatomic) UIBezierPath *smallTrianglePath;
@property (strong, nonatomic) UIBezierPath *leftTrianglePath;
@property (strong, nonatomic) UIBezierPath *rightTrianglePath;
@property (strong, nonatomic) UIBezierPath *topTrianglePath;

@end
static const CGFloat paddingSpace = 10.0;


@implementation TriangleLayer
-(instancetype)init{
    if (self == [super init]) {
    self.fillColor = [UIColor colorWithRed:0.697 green:0.391 blue:1.000 alpha:1.000].CGColor;
    self.strokeColor = [UIColor colorWithRed:0.697 green:0.391 blue:1.000 alpha:1.000].CGColor;
        self.lineWidth = 7.0;
//        self.fillColor = [UIColor redColor].CGColor;
//        self.strokeColor = [UIColor greenColor].CGColor;
        self.lineCap = kCALineCapRound;
        self.lineJoin = kCALineJoinRound;
        self.path = self.smallTrianglePath.CGPath;
    }
    return self;
}
- (UIBezierPath *)smallTrianglePath {
    if (!_smallTrianglePath) {
        _smallTrianglePath = [[UIBezierPath alloc] init];
        [_smallTrianglePath moveToPoint:CGPointMake(50, 20 )];
        [_smallTrianglePath addLineToPoint:CGPointMake(paddingSpace + 5, 95 - paddingSpace - 10)];
        [_smallTrianglePath addLineToPoint:CGPointMake(95.0 - paddingSpace, 95 - paddingSpace - 10)];
        [_smallTrianglePath closePath];
    }
    return _smallTrianglePath;
}

-(UIBezierPath *)leftTrianglePath{
    if (!_leftTrianglePath) {
        _leftTrianglePath = [[UIBezierPath alloc]init];
        [_leftTrianglePath moveToPoint:CGPointMake(50, 20)];
        [_leftTrianglePath addLineToPoint:CGPointMake(paddingSpace + 5 - 20, 95 - paddingSpace -10)];
        [_leftTrianglePath addLineToPoint:CGPointMake(95.0 - paddingSpace, 95 - paddingSpace -10)];
        [_leftTrianglePath closePath];
    }
    return _leftTrianglePath;
}

-(UIBezierPath *)rightTrianglePath{
    if (!_rightTrianglePath) {
        _rightTrianglePath = [[UIBezierPath alloc]init];
        [_rightTrianglePath moveToPoint:CGPointMake(50, 20)];
        [_rightTrianglePath addLineToPoint:CGPointMake(paddingSpace + 5 - 20, 95 - paddingSpace -10)];
        [_rightTrianglePath addLineToPoint:CGPointMake(95.0 - paddingSpace + 20, 95 - paddingSpace -10)];
        [_rightTrianglePath closePath];

    }
    return _rightTrianglePath;
}

-(UIBezierPath *)topTrianglePath{
    if (!_topTrianglePath) {
        _topTrianglePath = [[UIBezierPath alloc]init];
        [_topTrianglePath moveToPoint:CGPointMake(50, -10)];
        [_topTrianglePath addLineToPoint:CGPointMake(paddingSpace + 5 - 20, 95 - paddingSpace -10)];
        [_topTrianglePath addLineToPoint:CGPointMake(95.0 - paddingSpace + 20, 95 - paddingSpace -10)];
        [_topTrianglePath closePath];
    }
    return _topTrianglePath;
}

- (void)triangleAnimate {
    //left
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id _Nullable)(self.smallTrianglePath.CGPath);
    animation.toValue = (__bridge id _Nullable)(self.leftTrianglePath.CGPath);
    animation.beginTime = 0.f;
    animation.duration = 0.3;
    
    //right
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation2.fromValue = (__bridge id _Nullable)(self.leftTrianglePath.CGPath);
    animation2.toValue = (__bridge id _Nullable)(self.rightTrianglePath.CGPath);
    animation2.beginTime = animation.beginTime + animation.duration;
    animation2.duration = 0.3;
    
    //top
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation3.fromValue = (__bridge id _Nullable)(self.rightTrianglePath.CGPath);
    animation3.toValue = (__bridge id _Nullable)(self.topTrianglePath.CGPath);
    animation3.beginTime = animation2.beginTime + animation.duration;
    animation3.duration = 0.3;
    
    CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
    animationGroup.animations = @[animation,animation2,animation3];
    animationGroup.duration = animation3.beginTime + animation3.duration;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    [self addAnimation:animationGroup forKey:nil];
}

@end
