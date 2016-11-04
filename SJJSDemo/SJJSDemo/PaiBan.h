//
//  PaiBan.h
//  SJJSDemo
//
//  Created by jiemo on 15/10/31.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PaiBan;
@protocol PaiBanDelegate <NSObject>

-(void)lockView:(PaiBan *)lockView didSeletedPassowrd:(NSString *)password;

@end
@interface PaiBan : UIView
@property(nonatomic,weak)id<PaiBanDelegate> delegate;
@end
