//
//  ViewController.m
//  UISnapBehaviorStudy
//
//  Created by jiemo on 16/11/2.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UIDynamicAnimator *animator;
@property (nonatomic,strong) UIView *squreView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *squre = [[UIView alloc]initWithFrame:CGRectMake(0,0,50,50)];
    squre.backgroundColor = [UIColor redColor];
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    self.squreView = squre;
    [self.view addSubview:squre];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    [self.animator removeAllBehaviors];
    UISnapBehavior *snap = [[UISnapBehavior alloc]initWithItem:self.squreView snapToPoint:point];
    snap.damping = 0.7;
    [self.animator addBehavior:snap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
