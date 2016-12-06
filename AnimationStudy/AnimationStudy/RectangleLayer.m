//
//  RectangleLayer.m
//  AnimationStudy
//
//  Created by jiemo on 16/7/6.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "RectangleLayer.h"
@interface RectangleLayer()
@property (strong, nonatomic) UIBezierPath *rectangleFullPath;
@end
@implementation RectangleLayer
- (instancetype)init{
    if (self == [super init]) {
        self.fillColor = [UIColor clearColor].CGColor;
        self.lineWidth = 5.f;
        self.path = self.rectangleFullPath.CGPath;
    }
    return self;
}

-(UIBezierPath *)rectangleFullPath{
    if (!_rectangleFullPath) {
        _rectangleFullPath = [[UIBezierPath alloc]init];
        [_rectangleFullPath moveToPoint:CGPointMake(-7, 75 + 2)];
        [_rectangleFullPath addLineToPoint:CGPointMake(107, 75+2)];
        [_rectangleFullPath addLineToPoint:CGPointMake(107, -50+2)];
        [_rectangleFullPath addLineToPoint:CGPointMake(-7, -50+2)];
        [_rectangleFullPath closePath];
    }
    return _rectangleFullPath;
}

- (void)strokeChangeWithColor:(UIColor *)color {
    self.strokeColor = color.CGColor;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.duration = 0.4;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self addAnimation:animation forKey:nil];
}
@end
