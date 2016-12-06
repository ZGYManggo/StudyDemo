//
//  MagicTransition.m
//  CustomTransition
//
//  Created by jiemo on 16/11/30.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "MagicTransition.h"
#import "MagicMoveController.h"
#import "BigImageController.h"
@interface MagicTransition()
@property (nonatomic, assign) PresentTransitionType type;

@end


@implementation MagicTransition
+ (instancetype)transitionWithTransitionType:(PresentTransitionType)type{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(PresentTransitionType)type{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5f;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    switch (self.type) {
        case PresentOneTransitionTypePresent:
            [self presentAnimation:transitionContext];
            break;
        case PresentOneTransitionTypeDismiss:
            [self dismissAnimation:transitionContext];
            break;
        default:
            break;
    }
}
- (void)presentAnimation:(id <UIViewControllerContextTransitioning>)transitionContext{
    NSLog(@"%@",NSStringFromClass([[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey] class]));
    UINavigationController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    BigImageController *toVC = (BigImageController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    MagicMoveController *fromMaggic = fromVC.viewControllers.lastObject;
    UIView *containerView = [transitionContext containerView];
    
    MagicMoveCell *cell = [fromMaggic.thisTableView cellForRowAtIndexPath:fromMaggic.indexPathRow];
    UIView *tempView = [cell.thisImageView snapshotViewAfterScreenUpdates:NO];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    tempView.frame = [cell.thisImageView convertRect:cell.imageView.frame toView: containerView];

    [containerView addSubview:tempView];
    [containerView addSubview:toVC.view];
    toVC.view.alpha = 0;
    toVC.image.hidden = YES;
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
//    [UIView animateWithDuration:10 delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1 / 0.55 options:0 animations:^{
//        tempView.frame = [toVC.image convertRect:toVC.image.bounds toView:containerView];
//        toVC.view.alpha = 1;
//    } completion:^(BOOL finished) {
//        tempView.hidden = YES;
//        toVC.image.hidden = NO;
//        [transitionContext completeTransition:YES];
//    }];
    [UIView animateWithDuration:0.5 animations:^{
        tempView.frame = [toVC.image convertRect:toVC.image.bounds toView:containerView];
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        tempView.hidden = YES;
        toVC.image.hidden = NO;
        [transitionContext completeTransition:YES];

    }];

}

- (void)dismissAnimation:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [[transitionContext containerView].subviews firstObject];
}
@end
