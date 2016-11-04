//
//  ViewController.m
//  链式编程加法计算器
//
//  Created by jiemo on 16/10/16.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Caculate.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  int i =  [NSObject makeCaculate:^(CaculateManger *mgr) {
        mgr.add(1).add(5);
    }];
    NSLog(@"%d",i);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
