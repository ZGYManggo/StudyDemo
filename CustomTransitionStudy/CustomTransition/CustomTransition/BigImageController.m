//
//  BigImageController.m
//  CustomTransition
//
//  Created by jiemo on 16/11/30.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "BigImageController.h"
#import "UIView+ZgyExtension.h"
#import "MagicTransition.h"
@interface BigImageController ()<UIScrollViewDelegate,UIViewControllerTransitioningDelegate>
@property (nonatomic,strong) UIScrollView *thisScroll;
@end

@implementation BigImageController
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
    self.thisScroll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.thisScroll];
    UIImage *image = [UIImage imageNamed:self.imageName];
    UIImageView *bigImg = [[UIImageView alloc]initWithImage:image];

    self.thisScroll.maximumZoomScale = image.size.width / (self.view.zg_width - 20) > 1 ? image.size.width / (self.view.zg_width - 20) : 1;
    CGFloat x = (self.view.zg_width - 20)/image.size.width;
    CGFloat heigh = image.size.height * x;
    bigImg.frame = CGRectMake(10, 0, self.view.zg_width - 20, heigh);
    CGPoint center = bigImg.center;
    center.y =self.view.zg_height  / 2;
//    bigImg.center = center;
    bigImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.thisScroll addSubview:bigImg];
    self.image = bigImg;
    self.thisScroll.delegate = self;
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backBtn setTitle:@"后退" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(tppedBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:backBtn aboveSubview:self.thisScroll];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.image;
}

- (void)tppedBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
//}
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    NSLog(@"%@",NSStringFromClass([presented class]));
    NSLog(@"%@",NSStringFromClass([presenting class]));
    NSLog(@"%@",NSStringFromClass([source class]));

    return [MagicTransition transitionWithTransitionType:PresentOneTransitionTypePresent];

}
@end
