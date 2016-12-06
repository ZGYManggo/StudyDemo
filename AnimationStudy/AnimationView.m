//
//  AnimationView.m
//  AnimationStudy
//
//  Created by jiemo on 16/7/5.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "AnimationView.h"
#import "CircleLayer.h"
#import "TriangleLayer.h"
#import "RectangleLayer.h"
@interface AnimationView()
@property (strong, nonatomic) CircleLayer *circleLayer;
@property (strong, nonatomic) TriangleLayer *triangleLayer;
@property (strong, nonatomic) RectangleLayer *redRectangleLayer;
@property (strong, nonatomic) RectangleLayer *blueRectangleLayer;
@end
@implementation AnimationView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addCircleLayer];
    }
    return self;
}
- (CircleLayer *)circleLayer {
    if (!_circleLayer) {
        _circleLayer = [[CircleLayer alloc] init];
    }
    return _circleLayer;
}

- (TriangleLayer *)triangleLayer{
    if (!_triangleLayer) {
        _triangleLayer = [[TriangleLayer alloc]init];
    }
    return _triangleLayer;
}
-(RectangleLayer *)redRectangleLayer{
    if (!_redRectangleLayer) {
        _redRectangleLayer = [[RectangleLayer alloc]init];
        
    }
    return _redRectangleLayer;
}
-(RectangleLayer *)blueRectangleLayer{
    if (!_blueRectangleLayer) {
        _blueRectangleLayer = [[RectangleLayer alloc]init];
        
    }
    return _blueRectangleLayer;
}
- (void)addCircleLayer {
    [self.layer addSublayer:self.circleLayer];
    [_circleLayer expand];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(wobbleCircleLayer) userInfo:nil repeats:NO];
}
- (void)wobbleCircleLayer {
    [_circleLayer wobbleAnimation];
    [self.layer addSublayer:self.triangleLayer];
    [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(showTriangleAnimation) userInfo:nil repeats:NO];
}
- (void)showTriangleAnimation {
    [self.triangleLayer triangleAnimate];
    [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(transformAnima) userInfo:nil repeats:NO];
}
- (void)transformAnima {
    [self transformRotationZ];
    [_circleLayer contract];
    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(drawRedRectangleAnimation) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(drawBlueRectangleAnimation) userInfo:nil repeats:NO];
}
- (void)transformRotationZ {
    self.layer.anchorPoint = CGPointMake(0.5, 0.5);
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI * 2);
    rotationAnimation.duration = 0.45;
    rotationAnimation.removedOnCompletion = YES;
    [self.layer addAnimation:rotationAnimation forKey:nil];
}

- (void)drawRedRectangleAnimation {
    [self.layer addSublayer:self.redRectangleLayer];
    [_redRectangleLayer strokeChangeWithColor:[UIColor colorWithRed:0.697 green:0.391 blue:1.000 alpha:1.000]];
    
}

- (void)drawBlueRectangleAnimation {
    [self.layer addSublayer:self.blueRectangleLayer];
    [_blueRectangleLayer strokeChangeWithColor:[UIColor colorWithRed:0.082 green:1.000 blue:0.869 alpha:1.000]];
//    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(drawWaveAnimation) userInfo:nil repeats:NO];
}
@end
