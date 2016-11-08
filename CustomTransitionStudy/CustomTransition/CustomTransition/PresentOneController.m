//
//  PresentOneController.m
//  CustomTransition
//
//  Created by jiemo on 16/11/8.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "PresentOneController.h"
#import "PresentTwoController.h"
@interface PresentOneController ()

@end

@implementation PresentOneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg01.jpg"]];
    bgView.frame = self.view.bounds;
    [self.view addSubview:bgView];
    
    UIButton *presentButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 30, self.view.bounds.size.height/ 2 - 30, 60, 60)];
    [presentButton setTitle:@"present" forState:UIControlStateNormal];
    [presentButton addTarget:self action:@selector(tappedPresentBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentButton];
}
- (void)tappedPresentBtn{
    PresentTwoController *VC = [[PresentTwoController alloc]init];
    [self presentViewController:VC animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
