//
//  InteroduceController.m
//  MyResume
//
//  Created by jiemo on 15/12/3.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import "InteroduceController.h"
#import "ZTypewriteEffectLabel.h"
@interface InteroduceController ()

@end

@implementation InteroduceController

- (void)viewDidLoad {
    [super viewDidLoad];
    //隐藏了navigationbar后手势返回失效，可以调用此方法，让手势返回生效
   // self.navigationController.interactivePopGestureRecognizer.delegate = (id) self;
    //添加返回手势
    UIScreenEdgePanGestureRecognizer *gesture=[[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(fanhui)];
    gesture.edges=UIRectEdgeLeft;
    [self.view addGestureRecognizer:gesture];
    self.view.backgroundColor = [UIColor blackColor];
    
    ZTypewriteEffectLabel *myLbl = [[ZTypewriteEffectLabel alloc] initWithFrame:CGRectMake(0,20, 350, 550)];
    myLbl.hasSound=NO;
    myLbl.tag = 10;
    myLbl.backgroundColor = [UIColor clearColor];
    myLbl.numberOfLines = 0;
    
    myLbl.text = @"个人简介：  \n\n\t 在校期间担任的学习委员让我充当了沟通老师和学生间的桥梁，懂得了如何却化解矛盾，如何让语言发挥作用。\n\n\t担任社团组织部部长一职时，让我懂得了团队分配。\n\n\t在校完成网页项目时，我懂得了团队的沟通与合作，在团队中要学会忍让和互相欣赏，这样的团队氛围才是最棒的。 \n\n\t因为对新技术充满了兴趣，所以我很愿意去学习来提高自己，我自己也有经常去CSDN，OSChina，知乎上去看技术文章。偶尔会上github看他人写的代码。 \n\n\t之前在做JAVA开发，但是我最喜欢的还是移动端，移动端对我有着致命的吸引，所以我辞了之前的工作，自己在学IOS开发。\n\n\t虽然我并不是大牛级别的技术人员，但是我相信假以时日我会以我的努力来证明你的选择是没有错的。\n\n\t\t\t\t\t\t\t\tBy\t张高远  ";
    
    myLbl.textColor = self.view.backgroundColor;
    
    
    myLbl.typewriteEffectColor = [UIColor greenColor];
    myLbl.hasSound = YES;
    myLbl.typewriteTimeInterval = 0.1;
    
    UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(133, 617, 97, 30 )];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor greenColor]  forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.alpha=0;
    myLbl.typewriteEffectBlock = ^{
    
        [UIView animateWithDuration:1.5f animations:^{
            button.alpha=1;
                    }];
        
    };
    
    [self.view addSubview:myLbl];
    
    
    /** Z
     *	1秒后开始打印输出
     */
    [self performSelector:@selector(startOutPut) withObject:nil afterDelay:1];
    
}


-(void)startOutPut
{
    ZTypewriteEffectLabel *myLbl = (ZTypewriteEffectLabel *)[self.view viewWithTag:10];
    [myLbl startTypewrite];
}

-(void)fanhui{
    [self dismissViewControllerAnimated:YES completion:nil];

}



@end
