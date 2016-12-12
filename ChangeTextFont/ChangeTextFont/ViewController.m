//
//  ViewController.m
//  ChangeTextFont
//
//  Created by jiemo on 16/12/11.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "ViewController.h"
#import "FontLabel.h"
#import "SettingViewController.h"
#import "InputText.h"
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self resetDefaults];
    FontLabel *label = [[FontLabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = @"这是一段测试的文字，text test其中混杂着中文 english ENGLISH And のこれは私の日本語です";
    InputText *input = [[InputText alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 300)];
    input.text = @"这是一段测试的文字，text test其中混杂着中文 english ENGLISH And のこれは私の日本語です";
    UIButton *settingBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 30, SCREEN_HEIGHT - 60, 60, 60)];
    [settingBtn setTitle:@"设置" forState:UIControlStateNormal];
    [settingBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(tappedBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingBtn];
    [self.view addSubview:input];
    [self.view addSubview:label];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:ZGFont]);
    input.font = [UIFont fontWithName:[[NSUserDefaults standardUserDefaults] objectForKey:ZGFont] size:16.f];
    label.font = [UIFont fontWithName:[[NSUserDefaults standardUserDefaults] objectForKey:ZGFont] size:16.f];
}


- (void)tappedBtn {
    SettingViewController *VC = [[SettingViewController alloc]init];
    [self presentViewController:VC animated:YES completion:nil];
}

- (void)resetDefaults
{
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict)
    {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}
@end
