//
//  ViewController.m
//  ScrollViewUpTableView
//
//  Created by jiemo on 16/5/22.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITableView *mainTable = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    mainTable.rowHeight = 65;
    mainTable.separatorInset = UIEdgeInsetsMake(0, 75, 0, 75);
    mainTable.dataSource = self;
    mainTable.delegate = self;
    
    UIScrollView *mainScroll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    mainScroll.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    mainScroll.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    mainScroll.delegate = self;
    mainScroll.userInteractionEnabled = NO;
    [mainTable addGestureRecognizer:mainScroll.panGestureRecognizer];
    mainScroll.backgroundColor = [UIColor colorWithWhite:0.500 alpha:0.314];
    [self.view addSubview:mainTable];
    [self.view addSubview:mainScroll];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TbaleView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

@end
