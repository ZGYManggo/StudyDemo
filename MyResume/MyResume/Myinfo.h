//
//  Myinfo.h
//  MyResume
//
//  Created by jiemo on 15/11/23.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKSideSlipView.h"
#import "SKSplashView.h"
@interface Myinfo : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SKSplashDelegate>
{
    
    JKSideSlipView *_sideSlipView;
    
}

@end
