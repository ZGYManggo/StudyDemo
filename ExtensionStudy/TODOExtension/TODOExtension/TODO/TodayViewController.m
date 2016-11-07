//
//  TodayViewController.m
//  TODO
//
//  Created by jiemo on 16/11/6.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "DataTool.h"
@interface TodayViewController () <NCWidgetProviding,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *thisTable;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = [[DataTool shareDataTool]getData];
    if (arr.count) {
        return arr.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = [[DataTool shareDataTool]getData];
    if (!arr.count) {
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        cell.textLabel.text = @"点击添加";
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        [cell.contentView addSubview:btn];
        [btn addTarget:self action:@selector(tappedBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = arr[indexPath.row];
    return cell;
}

- (void)tappedBtn{
    [self.extensionContext openURL:[NSURL URLWithString:@"TODOExtensionStudy://addNewItem"] completionHandler:nil];
}

@end
