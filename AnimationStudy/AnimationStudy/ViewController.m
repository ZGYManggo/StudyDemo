//
//  ViewController.m
//  AnimationStudy
//
//  Created by jiemo on 16/7/5.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "ViewController.h"
#import "AnimationView.h"
#import "DrawView.h"
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    AnimationView *view = [[AnimationView alloc]initWithFrame:CGRectMake(200, 200, 100, 100)];
    [self.view addSubview:view];
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(6, 58, SCREEN_W - 16 - 12, 1)];
//    
//    view.backgroundColor = [UIColor colorWithWhite:0.929 alpha:1.000];
//    [self drawDashLine:view lineLength:8 lineSpacing:5 lineColor:[UIColor blackColor]];
//    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(8, 200, SCREEN_W - 16, 80)];
//    DrawView *draw = [[DrawView alloc]initWithFrame:CGRectMake(8, 200, SCREEN_W - 16, 80)];
//    draw.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:draw];
//    backView.backgroundColor = [UIColor colorWithWhite:0.976 alpha:1.000];
//    backView.layer.borderWidth = 0.5;
//    backView.layer.borderColor = [UIColor colorWithRed:0.307 green:0.345 blue:0.295 alpha:1.000].CGColor;
//    [backView addSubview:view];
//    backView.layer.masksToBounds = YES;
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-6, 52, 12, 12)];
//    path.lineWidth = 10;
//    CAShapeLayer *layer = [CAShapeLayer layer];
//    layer.path = path.CGPath;
////    layer.borderWidth = 10;
//    layer.borderColor =[UIColor colorWithRed:0.307 green:0.345 blue:0.295 alpha:1.000].CGColor;
//    layer.fillColor = [UIColor whiteColor].CGColor;
//    [backView.layer insertSublayer:layer above:backView.layer];
//    [self.view addSubview:backView];
//    CAShapeLayer *solidLine =  [CAShapeLayer layer];
//    CGMutablePathRef solidPath =  CGPathCreateMutable();
//    solidLine.lineWidth = 1.0f ;
//    solidLine.strokeColor = [UIColor orangeColor].CGColor;
//    solidLine.fillColor = [UIColor orangeColor].CGColor;
//    CGPathAddEllipseInRect(solidPath, nil, CGRectMake(-6.0f,  52.0f, 12.0f, 12.0f));
//    solidLine.path = solidPath;
//    CGPathRelease(solidPath);
//    [backView.layer insertSublayer:solidLine above:backView.layer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

- (void)draw:(UIView *)view{
  

}

@end
