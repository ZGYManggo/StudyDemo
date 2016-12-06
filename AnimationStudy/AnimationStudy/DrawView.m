//
//  DrawView.m
//  AnimationStudy
//
//  Created by jiemo on 16/8/4.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *drawPath = [UIBezierPath bezierPath];
    drawPath.lineWidth = 1;
    [drawPath moveToPoint:CGPointMake(0, 0)];
    [drawPath addLineToPoint:CGPointMake(0, 52)];
    [drawPath addArcWithCenter:CGPointMake(0, 58) radius:M_PI startAngle:M_PI endAngle:M_PI_2 clockwise:YES];
    UIColor *strokeColor = [UIColor blueColor];
    [strokeColor setStroke];
    [drawPath stroke];
}


@end
