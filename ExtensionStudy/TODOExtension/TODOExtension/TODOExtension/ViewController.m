//
//  ViewController.m
//  TODOExtension
//
//  Created by jiemo on 16/11/6.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "ViewController.h"
#import "DataTool.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *mainTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    mainTable.dataSource = self;
    mainTable.delegate = self;
    [self.view addSubview:mainTable];
    self.mainTableView =mainTable;
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(tappedAddButton)];
    self.navigationItem.rightBarButtonItem = item;
    NSArray *arr = [[DataTool shareDataTool]getData];
    self.dataArr = [NSMutableArray arrayWithArray:arr];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tappedAddButton) name:@"add" object:nil];
}

- (void)tappedAddButton{
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"添加" message:@"输入待添加的内容" preferredStyle:UIAlertControllerStyleAlert];
    [alter addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入";
        textField.secureTextEntry = NO;
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *userText = alter.textFields.firstObject;
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            [[DataTool shareDataTool]addData:userText.text];
            [self.dataArr addObject:userText.text];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mainTableView reloadData];
            });
        });
    }];
    [alter addAction:okAction];
    [self presentViewController:alter animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = (NSString *)self.dataArr[indexPath.row];
    return cell;
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self.dataArr removeObjectAtIndex:indexPath.row];
        [[DataTool shareDataTool]updataData:self.dataArr];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }];
    return @[action];
}

@end
