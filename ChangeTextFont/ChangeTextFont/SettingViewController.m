//
//  SettingViewController.m
//  ChangeTextFont
//
//  Created by jiemo on 16/12/12.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "SettingViewController.h"
#import "FontLabel.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *fontFailyArr;

@end

@implementation SettingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self fontArr];
    // Do any additional setup after loading the view.
    UITableView *settingTabel = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    settingTabel.delegate = self;
    settingTabel.dataSource = self;
    [self.view addSubview:settingTabel];

}

- (void)fontArr{
    int i = 0;
    self.fontFailyArr = [NSMutableArray array];
    for(NSString *fontfamilyname in [UIFont familyNames])
    {
        NSMutableDictionary *fontFailyDic = [NSMutableDictionary dictionary];

        fontFailyDic[@"fontFamilyName"] = fontfamilyname;
        NSMutableArray *tempFontNameArr = [NSMutableArray array];
        NSLog(@"family:'%@'",fontfamilyname);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
        {
            NSLog(@"\tfont:'%@'",fontName);
            [tempFontNameArr addObject:fontName];
        }
        NSLog(@"-------------%d",i++);
        fontFailyDic[@"fontName"] = tempFontNameArr;
        [self.fontFailyArr addObject:fontFailyDic];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.fontFailyArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dic = self.fontFailyArr[section];
    NSArray *data = dic[@"fontName"];
    return data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = self.fontFailyArr[indexPath.section];
    NSArray *data = dic[@"fontName"];
    NSString *fontName = data[indexPath.row];
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    cell.textLabel.text = @"这是段测试 text test";
    cell.detailTextLabel.text = fontName;
    cell.textLabel.font = [UIFont fontWithName:fontName size:18.f];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *dic = self.fontFailyArr[section];
    NSString *fontFamilyName = dic[@"fontFamilyName"];
    return fontFamilyName;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.fontFailyArr[indexPath.section];
    NSArray *data = dic[@"fontName"];
    NSString *fontName = data[indexPath.row];
    
    UIFont *font = [UIFont fontWithName:fontName size:16.f];
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSUserDefaults standardUserDefaults] setObject:fontName forKey:ZGFont];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:ZGFontChange object:font];
    }];
}

@end
