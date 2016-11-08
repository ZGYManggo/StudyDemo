//
//  PresntInteractiveTransition.h
//  CustomTransition
//
//  Created by jiemo on 16/11/8.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PresntInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic, assign) BOOL interacting;
- (instancetype)initWithViewController:(UIViewController*)viewController;
@end
