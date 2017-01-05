//
//  PrintViewController.h
//  CoreBluetoothStudy
//
//  Created by jiemo on 17/1/4.
//  Copyright © 2017年 张高远. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPeripheral.h"
@class PrintViewController;
@protocol  PrintViewControllerDelegate<NSObject>
@optional
- (void)PrintViewController:(PrintViewController *)printViewController data:(NSData *)data;

@end

@interface PrintViewController : UIViewController
@property (nonatomic,strong) MyPeripheral *connectedPeripheral;
@property (nonatomic,weak) id<PrintViewControllerDelegate> delegate;
@end
