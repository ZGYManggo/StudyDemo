//
//  MagicMoveController.m
//  CustomTransition
//
//  Created by jiemo on 16/11/30.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "MagicMoveController.h"
#import "BigImageController.h"
@interface MagicMoveController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MagicMoveController

-(UITableView *)thisTableView{
    if (!_thisTableView) {
        _thisTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _thisTableView.dataSource = self;
        _thisTableView.delegate = self;
    }
    return _thisTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.thisTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MagicMoveCell *cell = [[MagicMoveCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.indexPathRow = indexPath;
    BigImageController *VC = [[BigImageController alloc]init];
    VC.imageName = @"bg04.jpg";
    [self presentViewController:VC animated:YES completion:nil];
}
@end
