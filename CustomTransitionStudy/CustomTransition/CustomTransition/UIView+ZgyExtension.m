//
//  UIView+ZgyExtension.m
//  BSBDJ-ZGY
//
//  Created by jiemo on 16/11/9.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "UIView+ZgyExtension.h"

@implementation UIView (ZgyExtension)

-(CGFloat )zg_width{
    return self.frame.size.width;
}

-(void)setZg_width:(CGFloat )zg_width{
    CGRect frame = self.frame;
    frame.size.width = zg_width;
    self.frame = frame;
}
-(CGFloat )zg_height{
    return self.frame.size.height;
}

-(void)setZg_height:(CGFloat )zg_height{
    CGRect frame = self.frame;
    frame.size.height = zg_height;
    self.frame = frame;
}

-(CGFloat)zg_x{
    return self.frame.origin.x;
}

-(void)setZg_x:(CGFloat)zg_x{
    CGRect frame = self.frame;
    frame.origin.x = zg_x;
    self.frame = frame;
}

-(CGFloat)zg_y{
    return self.frame.origin.y;
}

-(void)setZg_y:(CGFloat)zg_y{
    CGRect frame = self.frame;
    frame.origin.y = zg_y;
    self.frame = frame;
}

-(CGFloat)zg_maxX{
    return CGRectGetMaxX(self.frame);
}

-(void)setZg_maxX:(CGFloat)zg_maxX{
    //do nothing
}

-(CGFloat)zg_maxY{
    return CGRectGetMaxY(self.frame);
}

-(void)setZg_maxY:(CGFloat)zg_maxY{
    //do nothing
}

-(CGSize)zg_size{
    return self.frame.size;
}

-(void)setZg_size:(CGSize)zg_size{
    CGRect frame = self.frame;
    frame.size = zg_size;
    self.frame = frame;
}

-(CGFloat)zg_centerX{
    return self.center.x;
}

-(void)setZg_centerX:(CGFloat)zg_centerX{
    CGPoint center = self.center;
    center.x = zg_centerX;
    self.center = center;
}

-(CGFloat)zg_centerY{
    return self.center.y;
}

-(void)setZg_centerY:(CGFloat)zg_centerY{
    CGPoint center = self.center;
    center.y = zg_centerY;
    self.center = center;
}

- (UIViewController *)findParentController{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            UIViewController *VC = (UIViewController*)nextResponder;
            return VC;
        }
    }
    return nil;
}

@end
