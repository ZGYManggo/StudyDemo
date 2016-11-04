//
//  kbToolbar.h
//  MyResume
//
//  Created by jiemo on 15/12/2.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class kbToolbar;
@protocol kbToolbarDelegate <NSObject>
@optional

/**
 *  item.tag  0 表示上一个按钮 1:下一个按钮 2:done完成按钮
 */
-(void)keyboardToolbar:(kbToolbar *)toolbar btndidSelected:(UIBarButtonItem *)item;
@end
@interface kbToolbar : UIToolbar


@property(weak,nonatomic) id<kbToolbarDelegate> kbdelegate;
+(instancetype)kbToolbar;

/**
 *  上一个按钮
 */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *previousItem;

/**
 *  下一个按钮
 */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextItem;
@end
