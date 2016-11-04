//
//  IBVIew.m
//  IBDesignable
//
//  Created by jiemo on 16/2/24.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "IBVIew.h"
IB_DESIGNABLE
@implementation IBVIew

- (void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius  = _cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setBcolor:(UIColor *)bcolor{
    _bcolor = bcolor;
    self.layer.borderColor = _bcolor.CGColor;
}

- (void)setBwidth:(CGFloat)bwidth {
    _bwidth = bwidth;
    self.layer.borderWidth = _bwidth;
}
-(void)setBgcolor:(UIColor *)bgcolor{
    _bgcolor = bgcolor;
    self.backgroundColor = _bgcolor;
}
@end
