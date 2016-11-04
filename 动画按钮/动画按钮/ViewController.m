//
//  ViewController.m
//  动画按钮
//
//  Created by jiemo on 15/11/5.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import "ViewController.h"
#import "ButtonMenu.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ButtonMenu *menubtn=[ButtonMenu ButtonMenu];
    CGFloat screenW = self.view.bounds.size.width;
    CGFloat screenH=self.view.bounds.size.height;
    menubtn.frame = CGRectMake(0, screenH-menubtn.bounds.size.height, screenW, 50);
    [self.view addSubview:menubtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
