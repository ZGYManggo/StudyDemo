//
//  CertificateController.m
//  MyResume
//
//  Created by jiemo on 15/12/4.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import "CertificateController.h"

@interface CertificateController ()
{
    int i;
}


@end

@implementation CertificateController

- (IBAction)fanhui:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //添加返回手势
    UIScreenEdgePanGestureRecognizer *gesture=[[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(fanhui:)];
    gesture.edges=UIRectEdgeLeft;
    [self.view addGestureRecognizer:gesture];
    self.scrollView.effect = JT3DScrollViewEffectTranslation;
    
    //    self.scrollView.delegate = self; // Use only for animate nextButton and previousButton
    
    [self createCardWithCET];
    [self createCardWithAvage];
    [self createCardWithjiangxuejin];
    [self createCardWithjiangxujin2];
    [self createCardWithshetuan];
}

- (void)createCardWithCET
{
    
    CGFloat width = CGRectGetWidth(self.scrollView.frame);
    CGFloat height = CGRectGetHeight(self.scrollView.frame);
    
    CGFloat x = self.scrollView.subviews.count * width;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, 0, width, height)];
    view.backgroundColor=[UIColor whiteColor];
    view.layer.cornerRadius = 30;
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 313, 260)];
    
    UIButton *likebutton=[[UIButton alloc]initWithFrame:CGRectMake(280, 318, 28, 24)];
    [likebutton setImage:[UIImage imageNamed:(i%2==0?@"2":@"1")]forState:UIControlStateNormal];
    [likebutton addTarget:self action:@selector(cilklike:) forControlEvents:UIControlEventTouchUpInside];
    likebutton.tag=1;
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 308, 313, 2 )];
    line.backgroundColor=[UIColor grayColor];

    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageview.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(30, 30)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = imageview.bounds;
    maskLayer.path = maskPath.CGPath;
    imageview.image=[UIImage imageNamed:@"CET-4"];
    imageview.layer.mask=maskLayer;
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(118, 262, 77, 21)];
    label.text=@"CET-4";
    UIFont *font=[UIFont fontWithName:@"Helvetica" size:21.f];
    label.font=font;
    label.textAlignment=NSTextAlignmentCenter;
    [view addSubview:likebutton];
    [view addSubview:imageview];
    [view addSubview:line];
    [view  addSubview:label];
    [self.scrollView addSubview:view];
    self.scrollView.contentSize = CGSizeMake(x + width, height);
}
- (void)createCardWithAvage
{
    
    CGFloat width = CGRectGetWidth(self.scrollView.frame);
    CGFloat height = CGRectGetHeight(self.scrollView.frame);
    
    CGFloat x = self.scrollView.subviews.count * width;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, 0, width, height)];
    view.backgroundColor=[UIColor whiteColor];
    view.layer.cornerRadius = 30;
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 313, 260)];
    //    imageview.layer.cornerRadius=40;
    //    imageview.layer.masksToBounds=YES;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageview.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(30, 30)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = imageview.bounds;
    maskLayer.path = maskPath.CGPath;
    imageview.image=[UIImage imageNamed:@"avagepoints"];
    imageview.layer.mask=maskLayer;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(118, 262, 77, 21)];
    label.text=@"绩点";
    UIFont *font=[UIFont fontWithName:@"Helvetica" size:21.f];
    label.font=font;
    label.textAlignment=NSTextAlignmentCenter;
    
    UIButton *likebutton=[[UIButton alloc]initWithFrame:CGRectMake(280, 318, 28, 24)];
    [likebutton setImage:[UIImage imageNamed:(i%2==0?@"2":@"1")]forState:UIControlStateNormal];
    [likebutton addTarget:self action:@selector(cilklike:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 308, 313, 2 )];
    line.backgroundColor=[UIColor grayColor];
    likebutton.tag=2;
    [view addSubview:likebutton];
    [view addSubview:imageview];
    [view addSubview:line];
    [view  addSubview:label];
    [self.scrollView addSubview:view];
    self.scrollView.contentSize = CGSizeMake(x + width, height);
}
- (void)createCardWithjiangxuejin
{
    
    CGFloat width = CGRectGetWidth(self.scrollView.frame);
    CGFloat height = CGRectGetHeight(self.scrollView.frame);
    
    CGFloat x = self.scrollView.subviews.count * width;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, 0, width, height)];
    view.backgroundColor=[UIColor whiteColor];
    view.layer.cornerRadius = 30;
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 313, 260)];
    //    imageview.layer.cornerRadius=40;
    //    imageview.layer.masksToBounds=YES;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageview.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(30, 30)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = imageview.bounds;
    maskLayer.path = maskPath.CGPath;
    imageview.image=[UIImage imageNamed:@"youtu"];
    imageview.layer.mask=maskLayer;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(118, 262, 107, 21)];
    label.text=@"三等奖学金";
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(200, 282, 107, 21)];
    label1.text=@"奖状遗失";
    UIFont *font1=[UIFont fontWithName:@"Helvetica" size:15.f];
    UIFont *font=[UIFont fontWithName:@"Helvetica" size:21.f];
    label.font=font;
    label1.font=font1;
    label.textAlignment=NSTextAlignmentCenter;
    
    UIButton *likebutton=[[UIButton alloc]initWithFrame:CGRectMake(280, 318, 28, 24)];
    [likebutton setImage:[UIImage imageNamed:(i%2==0?@"2":@"1")]forState:UIControlStateNormal];
    [likebutton addTarget:self action:@selector(cilklike:) forControlEvents:UIControlEventTouchUpInside];
    likebutton.tag=3;
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 308, 313, 2 )];
    line.backgroundColor=[UIColor grayColor];

    [view  addSubview:label1];
    [view addSubview:likebutton];
    [view addSubview:imageview];
    [view addSubview:line];
    [view  addSubview:label];
    [self.scrollView addSubview:view];
    self.scrollView.contentSize = CGSizeMake(x + width, height);
}
- (void)createCardWithshetuan
{
    
    CGFloat width = CGRectGetWidth(self.scrollView.frame);
    CGFloat height = CGRectGetHeight(self.scrollView.frame);
    
    CGFloat x = self.scrollView.subviews.count * width;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, 0, width, height)];
    view.backgroundColor=[UIColor whiteColor];
    view.layer.cornerRadius = 30;
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 313, 260)];
    //    imageview.layer.cornerRadius=40;
    //    imageview.layer.masksToBounds=YES;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageview.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(30, 30)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = imageview.bounds;
    maskLayer.path = maskPath.CGPath;
    imageview.image=[UIImage imageNamed:@"youtu"];
    imageview.layer.mask=maskLayer;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(98, 262, 147, 21)];
    label.text=@"优秀社团干部";
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(200, 282, 107, 21)];
    label1.text=@"奖状遗失";
    UIFont *font1=[UIFont fontWithName:@"Helvetica" size:15.f];
    UIFont *font=[UIFont fontWithName:@"Helvetica" size:21.f];
    label.font=font;
    label1.font=font1;
    
    UIButton *likebutton=[[UIButton alloc]initWithFrame:CGRectMake(280, 318, 28, 24)];
    [likebutton setImage:[UIImage imageNamed:(i%2==0?@"2":@"1")]forState:UIControlStateNormal];
    [likebutton addTarget:self action:@selector(cilklike:) forControlEvents:UIControlEventTouchUpInside];
    likebutton.tag=4;
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 308, 313, 2 )];
    line.backgroundColor=[UIColor grayColor];
    
    [view  addSubview:label1];
    [view addSubview:likebutton];
    [view addSubview:imageview];
    [view addSubview:line];
    [view  addSubview:label];
    [self.scrollView addSubview:view];
    self.scrollView.contentSize = CGSizeMake(x + width, height);
}
- (void)createCardWithjiangxujin2
{
    
    CGFloat width = CGRectGetWidth(self.scrollView.frame);
    CGFloat height = CGRectGetHeight(self.scrollView.frame);
    
    CGFloat x = self.scrollView.subviews.count * width;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, 0, width, height)];
    view.backgroundColor=[UIColor whiteColor];
    view.layer.cornerRadius = 30;
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 313, 260)];
    //    imageview.layer.cornerRadius=40;
    //    imageview.layer.masksToBounds=YES;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageview.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(30, 30)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = imageview.bounds;
    maskLayer.path = maskPath.CGPath;
    imageview.image=[UIImage imageNamed:@"youtu"];
    imageview.layer.mask=maskLayer;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(118, 262, 107, 21)];
    label.text=@"二等奖学金";
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(200, 282, 107, 21)];
    label1.text=@"即将获得";
    UIFont *font1=[UIFont fontWithName:@"Helvetica" size:15.f];
    UIFont *font=[UIFont fontWithName:@"Helvetica" size:21.f];
    label.font=font;
    label1.font=font1;
    label.textAlignment=NSTextAlignmentCenter;
    
    UIButton *likebutton=[[UIButton alloc]initWithFrame:CGRectMake(280, 318, 28, 24)];
    [likebutton setImage:[UIImage imageNamed:(i%2==0?@"2":@"1")]forState:UIControlStateNormal];
    [likebutton addTarget:self action:@selector(cilklike:) forControlEvents:UIControlEventTouchUpInside];
    likebutton.tag=5;
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 308, 313, 2 )];
    line.backgroundColor=[UIColor grayColor];
    
    [view  addSubview:label1];
    [view addSubview:likebutton];
    [view addSubview:imageview];
    [view addSubview:line];
    [view  addSubview:label];
    [self.scrollView addSubview:view];
    self.scrollView.contentSize = CGSizeMake(x + width, height);
}
-(void)cilklike:(UIButton *)sender {
    if (sender.tag==1) {
        i++;
        [sender setImage:[UIImage imageNamed:(i%2==0?@"2":@"1")]forState:UIControlStateNormal];
    }else if(sender.tag==2){
        i++;
        [sender setImage:[UIImage imageNamed:(i%2==0?@"2":@"1")]forState:UIControlStateNormal];
    }else if(sender.tag==3){
        i++;
        [sender setImage:[UIImage imageNamed:(i%2==0?@"2":@"1")]forState:UIControlStateNormal];
    }else if(sender.tag==4){
        i++;
        [sender setImage:[UIImage imageNamed:(i%2==0?@"2":@"1")]forState:UIControlStateNormal];
    }else if(sender.tag==5){
        i++;
        [sender setImage:[UIImage imageNamed:(i%2==0?@"2":@"1")]forState:UIControlStateNormal];
    }



}

@end
