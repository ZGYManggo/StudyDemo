//
//  ViewController.m
//  SpringButton
//
//  Created by jiemo on 16/10/12.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CAShapeLayer *circle;
//    NSTimer *timer;
}
@property (weak, nonatomic) IBOutlet UIButton *login;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.login.layer.cornerRadius = 30.f;
//    self.login.layer.masksToBounds = YES;
    [self.login addTarget:self action:@selector(tappedDown) forControlEvents:UIControlEventTouchDown];
    [self.login addTarget:self action:@selector(tappedUp) forControlEvents:UIControlEventTouchUpInside];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tappedDown{
    [UIView animateWithDuration:0.25 delay:0.f usingSpringWithDamping:0.8 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.login.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:nil];
    
}

- (void)test{
    if (circle.strokeEnd <=1) {
        circle.strokeEnd +=0.1;
        
    }
}

- (void)tappedUp{
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.login.transform = CGAffineTransformMakeScale(1.3, 1.3);
        
    } completion:^(BOOL finished) {
         [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
             self.login.transform = CGAffineTransformMakeScale(1, 1);

         } completion:^(BOOL finished){
//             self.login.enabled = NO;
             circle = [CAShapeLayer layer];
             circle.frame = CGRectMake(0, 0, 80, 80);

             UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(40, 40) radius:34  startAngle:-M_PI_2 endAngle:M_PI * 2 clockwise:YES];
             circle.path = path.CGPath;
             circle.fillColor = [UIColor grayColor].CGColor;
             circle.strokeColor = [UIColor grayColor].CGColor;
             circle.lineWidth = 3;
             circle.strokeStart = 0;
             circle.strokeEnd = 0;
             circle.lineCap = kCALineCapRound;
             circle.fillColor = [UIColor clearColor].CGColor;
             CAGradientLayer *gradLayer = [CAGradientLayer layer];

             gradLayer.frame = CGRectMake(-10, -10, 80, 80);
             gradLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                                  (__bridge id)[UIColor greenColor].CGColor,
                                  (__bridge id)[UIColor blueColor].CGColor];
             gradLayer.locations  = @[@(0.25), @(0.5), @(1)];
             gradLayer.startPoint = CGPointMake(0.5, 0);
             gradLayer.endPoint = CGPointMake(0.5, 1);
             gradLayer.mask = circle;
//             [gradLayer addSublayer:circle];
             [self.login.layer addSublayer:gradLayer];
             
             CABasicAnimation *animation = [CABasicAnimation animation];
             animation.keyPath = @"transform.rotation.z";
             animation.fromValue = @0;
             animation.toValue = @(M_PI * 2);
             animation.repeatCount = MAXFLOAT;
             animation.duration = 0.5f;
             [circle addAnimation:animation forKey:nil];
//             timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(test) userInfo:nil repeats:YES];
//             [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
           NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
                 if (circle.strokeEnd <1) {
                     circle.strokeEnd +=0.01;
                     
                 }
             }];
             [timer fire];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 for (UIView *view in self.login.subviews) {
                     [view removeFromSuperview];
                 }
                 for (CALayer *layer  in self.login.layer.sublayers) {
                     [layer removeFromSuperlayer];
                 }
                 
                [UIView animateWithDuration:0.5 animations:^{
                    self.login.transform = CGAffineTransformMakeScale(20,20);
                    self.login.alpha = 0.2;
                } completion:^(BOOL finished) {
                    [self.login removeFromSuperview];
                }];
                 
             });
         }];

    }];
}

     
     
@end
