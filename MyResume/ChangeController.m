//
//  ChangeController.m
//  MyResume
//
//  Created by jiemo on 15/12/2.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import "ChangeController.h"
#import "DBManager.h"
@interface ChangeController ()
@property (nonatomic,copy) NSString *plistPath;
@end

@implementation ChangeController
-(NSString *)plistPath{
    if (!_plistPath) {
        
        // 获取document目录
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        _plistPath = [doc stringByAppendingPathComponent:@"Myinfo.archiver"];
    }
    
    return _plistPath;
    
}
- (IBAction)cannel:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)confirm:(UIButton *)sender {
       DBManager *myinfo=[DBManager shareInstance];
    if (myinfo.name&&myinfo.sex&&myinfo.brithday) {
        [NSKeyedArchiver archiveRootObject:myinfo toFile:self.plistPath];
    }
 
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
