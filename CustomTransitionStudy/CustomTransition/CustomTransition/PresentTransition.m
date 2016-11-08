//
//  PresentTransition.m
//  CustomTransition
//
//  Created by jiemo on 16/11/8.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "PresentTransition.h"
@interface PresentTransition()

@property (nonatomic, assign) PresentTransitionType type;

@end
@implementation PresentTransition

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
    return _type == PresentOneTransitionTypePresent ? 0.5 : 0.25;

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
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    fromVC.view.hidden = YES;

    [containerView addSubview:tempView];
    [containerView addSubview:toVC.view];
    toVC.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 400);
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{

        toVC.view.transform = CGAffineTransformMakeTranslation(0, -400);
        tempView.transform = CGAffineTransformMakeScale(0.85, 0.85);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            fromVC.view.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
}

- (void)dismissAnimation:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [[transitionContext containerView].subviews firstObject];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        tempView.transform = CGAffineTransformIdentity;
        fromVC.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];

}

@end
