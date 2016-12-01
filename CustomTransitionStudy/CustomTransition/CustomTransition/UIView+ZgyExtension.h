//
//  UIView+ZgyExtension.h
//  BSBDJ-ZGY
//
//  Created by jiemo on 16/11/9.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZgyExtension)

@property (nonatomic,assign) CGFloat zg_height;
@property (nonatomic,assign) CGFloat zg_width;
@property (nonatomic,assign) CGFloat zg_x;
@property (nonatomic,assign) CGFloat zg_y;
@property (nonatomic,assign) CGFloat zg_maxY;
@property (nonatomic,assign) CGFloat zg_maxX;
@property (nonatomic,assign) CGSize zg_size;
@property (nonatomic,assign) CGFloat zg_centerX;
@property (nonatomic,assign) CGFloat zg_centerY;

- (UIViewController *)findParentController;

@end
