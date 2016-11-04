//
//  SkillController.m
//  MyResume
//
//  Created by jiemo on 15/12/3.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import "SkillController.h"
#import <QuartzCore/QuartzCore.h>
@interface SkillController ()

@end

@implementation SkillController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}
- (IBAction)fanhui:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //隐藏了navigationbar后手势返回失效，可以调用此方法，让手势返回生效
   // self.navigationController.interactivePopGestureRecognizer.delegate = (id) self;
    //添加返回手势
    UIScreenEdgePanGestureRecognizer *gesture=[[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(fanhui:)];
    gesture.edges=UIRectEdgeLeft;
    [self.view addGestureRecognizer:gesture];
    self.scrollView.effect = JT3DScrollViewEffectCards;
    
//    self.scrollView.delegate = self; // Use only for animate nextButton and previousButton
    
    [self createCardWithJAVA];
    [self createCardWithSwift];
    [self createCardWithC];
    [self createCardWithOC];
    [self createCardWithSQL];
}

- (void)createCardWithJAVA
{
    CGFloat width = CGRectGetWidth(self.scrollView.frame);
    CGFloat height = CGRectGetHeight(self.scrollView.frame);
    
    CGFloat x = self.scrollView.subviews.count * width;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, 0, width, height)];
 
    view.backgroundColor=[UIColor whiteColor];
    view.layer.cornerRadius = 18;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(170, 70, 40, 20)];
    label.text=@"熟练";
    UITextView *text1=[[UITextView alloc]initWithFrame:CGRectMake(0, 105, 375,140)];
    text1.editable=NO;
    UITextView *text2=[[UITextView alloc]initWithFrame:CGRectMake(0, 265, 375,280)];
    text2.editable=NO;
 
    text1.text=@"项目名称：在线聊天网页\n\n\t使用工具:Myeclipse 10，mysql，Tomcat，Dreamweaver 8.0\n\n\t实现功能：使用JSP+Servlet布局使用CSS+DIV，采用了MVC设计模式，实现了用户可以在线聊天、上线用户提示、管理员踢人、用户注册、修改密码、在线人员列表、重复登录踢下线等功能。";
    text2.text=@"项目名称：微型企业管理系统(j2se程序)\n\n\t使用工具:eclipse，SQL Server\n\n\t实现功能：一个可以在界面上运行的J2SE小程序。里面实现了各个部门经理登录、修改密码、管理员工（CRUD）、在线聊天等功能。\n\n\n\t项目名称：坦克游戏\n\n\t使用工具:eclipse\n\n\t实现功能：小型java程序，实现了坦克发子弹、攻击敌人坦克、记录分数等功能。";
    UIFont *font=[UIFont fontWithName:@"Helvetica" size:16.f];
    text1.font=font;
    text2.font=font;
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(5, 574, 360, 21)];
    label2.text=@"实习单位：拓尔斯  实习时间：2015.9~2015.11";
    label2.backgroundColor=[UIColor lightGrayColor];
    [view addSubview:label];
    [view addSubview:text1];
    [view addSubview:text2];
    [view addSubview:label2];
    [view addSubview:[self labelOfTitle:@"JAVA"]];
    [self.scrollView addSubview:view];
    self.scrollView.contentSize = CGSizeMake(x + width, height);
}
- (void)createCardWithSwift
{
    CGFloat width = CGRectGetWidth(self.scrollView.frame);
    CGFloat height = CGRectGetHeight(self.scrollView.frame);
    
    CGFloat x = self.scrollView.subviews.count * width;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, 0, width, height)];
    
    view.backgroundColor=[UIColor whiteColor];
    view.layer.cornerRadius = 18;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(170, 70, 40, 20)];
    label.text=@"入门";
    UITextView *text1=[[UITextView alloc]initWithFrame:CGRectMake(0, 105, 375,280)];
    text1.editable=NO;
    
    text1.text=@"项目名称：仿IOS计算器\n\n\t使用工具:xcode6.0\n\n\t实现功能：使用swift语言写出的一个模仿ios的计算器，采用了MVC设计模式，实现了加减乘除开根取反等运算。";
    UIFont *font=[UIFont fontWithName:@"Helvetica" size:16.f];
    text1.font=font;
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(268, 486, 94, 104)];
    imageview.image=[UIImage imageNamed:@"hua1"];
    [view addSubview:imageview];
    [view addSubview:label];
    [view addSubview:text1];
    [view addSubview:[self labelOfTitle:@"Swift"]];
    [self.scrollView addSubview:view];
    self.scrollView.contentSize = CGSizeMake(x + width, height);
}
- (void)createCardWithC
{
    CGFloat width = CGRectGetWidth(self.scrollView.frame);
    CGFloat height = CGRectGetHeight(self.scrollView.frame);
    
    CGFloat x = self.scrollView.subviews.count * width;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, 0, width, height)];
    
    view.backgroundColor=[UIColor whiteColor];
    view.layer.cornerRadius = 18;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(170, 70, 40, 20)];
    label.text=@"熟练";
    UITextView *text1=[[UITextView alloc]initWithFrame:CGRectMake(0, 105, 375,280)];
    text1.editable=NO;
    
    text1.text=@"项目名称：baby管理系统\n\n\t使用工具:VC++6.0\n\n\t实现功能：C语言实现的一个小型管理系统。用文件保存了所有信息。功能包括了用户注册、密码回显、排序、增删改查等功能。";
    UIFont *font=[UIFont fontWithName:@"Helvetica" size:16.f];
    text1.font=font;
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(268, 486, 94, 104)];
    imageview.image=[UIImage imageNamed:@"hua2"];
    [view addSubview:imageview];
    [view addSubview:label];
    [view addSubview:text1];
    [view addSubview:[self labelOfTitle:@"C语言"]];
    [self.scrollView addSubview:view];
    self.scrollView.contentSize = CGSizeMake(x + width, height);
}
- (void)createCardWithOC
{
    CGFloat width = CGRectGetWidth(self.scrollView.frame);
    CGFloat height = CGRectGetHeight(self.scrollView.frame);
    
    CGFloat x = self.scrollView.subviews.count * width;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, 0, width, height)];
    
    view.backgroundColor=[UIColor whiteColor];
    view.layer.cornerRadius = 18;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(170, 70, 40, 20)];
    label.text=@"熟练";
    UITextView *text1=[[UITextView alloc]initWithFrame:CGRectMake(0, 105, 375,280)];
    text1.editable=NO;
    
    text1.text=@"\t\t做过一些小demo，比如：天气预报，手势解锁，指纹解锁，计算器。了解ios基本控件的使用，会使用网络，多线程等。";
    UIFont *font=[UIFont fontWithName:@"Helvetica" size:16.f];
    text1.font=font;
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(268, 486, 94, 104)];
    imageview.image=[UIImage imageNamed:@"huaduo1"];
    [view addSubview:imageview];
    [view addSubview:label];
    [view addSubview:text1];
    [view addSubview:[self labelOfTitle:@"Objective-c"]];
    [self.scrollView addSubview:view];
    self.scrollView.contentSize = CGSizeMake(x + width, height);
}
- (void)createCardWithSQL
{
    CGFloat width = CGRectGetWidth(self.scrollView.frame);
    CGFloat height = CGRectGetHeight(self.scrollView.frame);
    
    CGFloat x = self.scrollView.subviews.count * width;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, 0, width, height)];
    
    view.backgroundColor=[UIColor whiteColor];
    view.layer.cornerRadius = 18;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(170, 70, 40, 20)];
    label.text=@"熟练";
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(268, 486, 94, 104)];
    imageview.image=[UIImage imageNamed:@"huoduo2"];
    [view addSubview:imageview];
    [view addSubview:label];
    [view addSubview:[self labelOfTitle:@"MySql"]];
    [self.scrollView addSubview:view];
    self.scrollView.contentSize = CGSizeMake(x + width, height);
}
#pragma mark - labefOftitle
-(UILabel *)labelOfTitle:(NSString *)title{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(105, 8, 165, 75)];
    label.text=title;
    UIFont *font=[UIFont fontWithName:@"Helvetica" size:21.f];
    label.font=font;
    label.textAlignment=NSTextAlignmentCenter;
    label.shadowColor=[UIColor lightGrayColor];
    label.shadowOffset=CGSizeMake(5, 4);

    return label;

}




@end
