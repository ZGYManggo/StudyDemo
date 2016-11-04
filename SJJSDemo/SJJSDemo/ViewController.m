//
//  ViewController.m
//  SJJSDemo
//
//  Created by jiemo on 15/10/30.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "PaiBan.h"
@interface ViewController ()<PaiBanDelegate>
@property (weak, nonatomic) IBOutlet UILabel *SignLeble;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PaiBan *p=[[PaiBan alloc]init];
    CGFloat screenW=[UIScreen mainScreen].bounds.size.width;
    p.frame=CGRectMake(0, 0, screenW, screenW);
    p.backgroundColor = [UIColor clearColor];
    p.center=self.view.center;
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]];
    p.delegate=self;
    [self.view addSubview:p];
//    [self authenticateUser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)lockView:(PaiBan *)lockView didSeletedPassowrd:(NSString *)password{
    if ([password isEqualToString:@"0124678"]) {
        [self performSegueWithIdentifier:@"gogo" sender:nil];
    }else{
       [UIView animateWithDuration:2.0 animations:^{
           self.SignLeble.alpha=1;
       } completion:^(BOOL finished) {
           [UIView animateWithDuration:2.0 animations:^{
                self.SignLeble.alpha=0;
           }];
          
       }
        ];
}
    
}
- (void)authenticateUser
    {
        //初始化上下文对象
        LAContext* context = [[LAContext alloc] init];
        //错误对象
        NSError* error = nil;
        NSString* result = @"按下你可爱的指纹验证.";
        
        //首先使用canEvaluatePolicy 判断设备支持状态
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            //支持指纹验证
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
                if (success) {
                    //验证成功，主线程处理UI
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        PaiBan *p=[[PaiBan alloc]init];
                        CGFloat screenW=[UIScreen mainScreen].bounds.size.width;
                        p.frame=CGRectMake(0, 0, screenW, screenW);
                        p.backgroundColor = [UIColor clearColor];
                        p.center=self.view.center;
                        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]];
                        p.delegate=self;
                        [self.view addSubview:p];
                    }];
                   
                }
                else
                {
                    NSLog(@"错误！！！");
                    switch (error.code) {
                        case LAErrorSystemCancel:
                        {
                            NSLog(@"Authentication was cancelled by the system");
                            //切换到其他APP，系统取消验证Touch ID
                            break;
                        }
                        case LAErrorUserCancel:
                        {
                            NSLog(@"Authentication was cancelled by the user");
                            //用户取消验证Touch ID
                            return ;
                            break;
                        }
                        case LAErrorUserFallback:
                        {
                            NSLog(@"User selected to enter custom password");
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                //用户选择输入密码，切换主线程处理
                                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"不支持密码输入" message:nil  preferredStyle:UIAlertControllerStyleAlert];
                                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                                    [self authenticateUser];
                                }];
                                [alertController addAction:cancelAction];
                                [self presentViewController:alertController animated:YES completion:nil];
                            }];
                            break;
                        }
                        default:
                        {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                //其他情况，切换主线程处理
                            }];
                            break;
                        }
                    }
                }
            }];
        }
        else
        {
            //不支持指纹识别，LOG出错误详情
            
            switch (error.code) {
                case LAErrorTouchIDNotEnrolled:
                {
                    NSLog(@"TouchID is not enrolled");
                    break;
                }
                case LAErrorPasscodeNotSet:
                {
                    NSLog(@"A passcode has not been set");
                    break;
                }
                default:
                {
                    NSLog(@"TouchID not available");
                    break;
                }
            }
            
            
        }
    }


@end
