//
//  MagicTransition.h
//  CustomTransition
//
//  Created by jiemo on 16/11/30.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, PresentTransitionType) {
    PresentOneTransitionTypePresent = 0,
    PresentOneTransitionTypeDismiss
};

@interface MagicTransition : NSObject<UIViewControllerAnimatedTransitioning>
+ (instancetype)transitionWithTransitionType:(PresentTransitionType)type;
- (instancetype)initWithTransitionType:(PresentTransitionType)type;
@end
