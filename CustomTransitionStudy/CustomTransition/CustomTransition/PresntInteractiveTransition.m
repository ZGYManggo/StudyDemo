//
//  PresntInteractiveTransition.m
//  CustomTransition
//
//  Created by jiemo on 16/11/8.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "PresntInteractiveTransition.h"
@interface PresntInteractiveTransition()
@property (nonatomic, assign) BOOL shouldComplete;

@property (nonatomic,strong) UIViewController *presentingVC;
@end
@implementation PresntInteractiveTransition
- (instancetype)initWithViewController:(UIViewController*)viewController{
    if (self = [super init]) {
        _presentingVC = viewController;
        [self prepareGestureRecognizerInView:_presentingVC.view];
    }
    return self;
}
- (void)prepareGestureRecognizerInView:(UIView*)view {
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:gesture];
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    NSLog(@"%@",NSStringFromCGRect(gestureRecognizer.view.frame));
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.interacting = YES;
            [self.presentingVC dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged: {
            CGFloat fraction = translation.y / gestureRecognizer.view.frame.size.height;
            NSLog(@"-----%0.2f",translation.y);

            self.shouldComplete = (fraction > 0.2);
            NSLog(@"%0.2f",fraction);
            CGFloat x = fraction * 0.4f;
            [self updateInteractiveTransition:x];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            self.interacting = NO;
            if (!self.shouldComplete) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

@end
