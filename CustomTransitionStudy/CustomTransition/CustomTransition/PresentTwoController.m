//
//  PresentTwoController.m
//  CustomTransition
//
//  Created by jiemo on 16/11/8.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "PresentTwoController.h"
#import "PresentTransition.h"
#import "PresntInteractiveTransition.h"
@interface PresentTwoController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic,strong) PresntInteractiveTransition *interactiveTransition;
@end

@implementation PresentTwoController

-(instancetype)init{
    if (self = [super init]) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg02.jpg"]];
    bgView.frame = self.view.bounds;
    [self.view addSubview:bgView];
    UIButton *dismissButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 30, self.view.bounds.size.height/ 2 - 30, 60, 60)];
    [dismissButton setTitle:@"present" forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(dismissButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissButton];
    self.interactiveTransition = [[PresntInteractiveTransition alloc]initWithViewController:self];


}
- (void)dismissButton{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [PresentTransition transitionWithTransitionType:PresentOneTransitionTypePresent];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [PresentTransition transitionWithTransitionType:PresentOneTransitionTypeDismiss];
}
-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.interactiveTransition.interacting?self.interactiveTransition : nil;

}

@end
