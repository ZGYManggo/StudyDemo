//
//  ViewController.m
//  masonryStudy
//
//  Created by jiemo on 16/7/4.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@interface ViewController ()
{
    UIView *sv;
}
@end

@implementation ViewController
-(void)tappedBtn
{
    WS(ws);
    [UIView animateWithDuration:10 animations:^{
        [sv mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.view).offset(50);
            make.left.equalTo(ws.view).offset(50);
        }];
        [self.view layoutIfNeeded];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    WS(ws);
    
    sv = [UIView new];
    sv.backgroundColor = [UIColor grayColor];
    [self.view addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 200));
        
        make.left.top.equalTo(ws.view).offset(50);
    }];
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeInfoLight];
//    UILabel *label = [UILabel new];
//    UIView *view = [UIView new];
//    label.text = @"123123123";
//    view.backgroundColor = [UIColor redColor];
//    [sv addSubview:btn];
//    [sv addSubview:label];
//    [sv addSubview:view];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(sv);
//        make.left.equalTo(sv.mas_left).offset(10);
//        make.right.equalTo(label.mas_left);
//    }];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(sv);
//        make.left.equalTo(btn.mas_right);
//        make.right.equalTo(sv);
//    }];
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
//    [btn setTitle:@"click" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(tappedBtn) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view).with.offset(-80);
//        make.centerX.equalTo(self.view);
//        make.size.mas_equalTo(CGSizeMake(44, 44));
//    }];
//    UIView *sv1 = [[UIView alloc]init];
//    sv1.backgroundColor = [UIColor redColor];
//    [self.view addSubview:sv1];
//    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(150);
//        make.centerY.equalTo(ws.view);
//        make.left.mas_equalTo(ws.view.mas_left).with.offset(10);
//        make.right.mas_equalTo(sv1.mas_left).with.offset(-10);
//        make.width.equalTo(sv1.mas_width);
//    }];
//    [sv1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(150);
//        make.width.equalTo(sv.mas_width);
//        make.left.mas_equalTo(sv.mas_right).with.offset(10);
//        make.right.mas_equalTo(ws.view.mas_right).with.offset(-10);
//        make.centerY.equalTo(ws.view);
//    }];
    [self exp4];
//    UIScrollView *scrollView = [UIScrollView new];
//    scrollView.backgroundColor = [UIColor whiteColor];
//    [sv addSubview:scrollView];
//    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(sv).with.insets(UIEdgeInsetsMake(5,5,5,5));
//    }];
//    UIView *container = [UIView new];
//    [scrollView addSubview:container];
//    [container mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(scrollView);
//        make.width.equalTo(scrollView);
////        make.top.equalTo(scrollView.mas_top);
//    }];
//    int count = 10;
//    UIView *lastView = nil;
//    for ( int i = 1 ; i <= count ; ++i )
//    {
//        UIView *subv = [UIView new];
//        [container addSubview:subv];
//        subv.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
//                                          saturation:( arc4random() % 128 / 256.0 ) + 0.5
//                                          brightness:( arc4random() % 128 / 256.0 ) + 0.5
//                                               alpha:1];
//        
//        [subv mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.and.right.equalTo(container);
//            make.height.mas_equalTo(@(20*i));
//            
//            if ( lastView )
//            {
//                make.top.mas_equalTo(lastView.mas_bottom);
//            }
//            else
//            {
//                make.top.mas_equalTo(container.mas_top);
//            }
//        }];
//        
//        lastView = subv;
//    }
//    [container mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(lastView.mas_bottom);
//    }];
}
-(void)exp4{
    //申明区域，displayView是显示区域，keyboardView是键盘区域
    UIView *displayView = [UIView new];
    [displayView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:displayView];
    UIView *keyboardView = [UIView new];
    [self.view addSubview:keyboardView];
    //先按1：3分割 displView（显示结果区域）和 keyboardView（键盘区域）
    [displayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.and.right.equalTo(self.view);
        make.height.equalTo(keyboardView).multipliedBy(0.3f);
    }];
    [keyboardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(displayView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.and.right.equalTo(self.view);
    }];
    //设置显示位置的数字为0
    UILabel *displayNum = [[UILabel alloc]init];
    [displayView addSubview:displayNum];
    displayNum.text = @"01321231232";
    displayNum.font = [UIFont fontWithName:@"HeiTi SC" size:70];
    displayNum.textColor = [UIColor whiteColor];
    displayNum.textAlignment = NSTextAlignmentRight;
    [displayNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(displayView).with.offset(-10);
        make.bottom.equalTo(displayView.mas_bottom).with.offset(10);
    }];
    //定义键盘键名称，？号代表合并的单元格
    NSArray *keys = @[@"AC",@"+/-",@"%",@"÷"
                      ,@"7",@"8",@"9",@"x"
                      ,@"4",@"5",@"6",@"-"
                      ,@"1",@"2",@"3",@"+"
                      ,@"0",@"?",@".",@"="];
    int indexOfKeys = 0;
    for (NSString *key in keys){
        //循环所有键
        indexOfKeys++;
        int rowNum = indexOfKeys %4 ==0? indexOfKeys/4:indexOfKeys/4 +1;
        int colNum = indexOfKeys %4 ==0? 4 :indexOfKeys %4;
        NSLog(@"index is:%d and row:%d,col:%d",indexOfKeys,rowNum,colNum);
        //键样式
        UIButton *keyView = [UIButton buttonWithType:UIButtonTypeCustom];
        [keyboardView addSubview:keyView];
        [keyView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [keyView setTitle:key forState:UIControlStateNormal];
        [keyView.layer setBorderWidth:1];
        [keyView.layer setBorderColor:[[UIColor blackColor]CGColor]];
        [keyView.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:30]];
        //键约束
        [keyView mas_makeConstraints:^(MASConstraintMaker *make) {
            //处理 0 合并单元格
            if([key isEqualToString:@"0"] || [key isEqualToString:@"?"] ){
                if([key isEqualToString:@"0"]){
                    [keyView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.height.equalTo(keyboardView.mas_height).with.multipliedBy(.2f);
                        make.width.equalTo(keyboardView.mas_width).multipliedBy(.5);
                        make.left.equalTo(keyboardView.mas_left);
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.9f);
                    }];
                }if([key isEqualToString:@"?"]){
                    [keyView removeFromSuperview];
                }
            }
            //正常的单元格
            else{
                make.width.equalTo(keyboardView.mas_width).with.multipliedBy(.25f);
                make.height.equalTo(keyboardView.mas_height).with.multipliedBy(.2f);
                //按照行和列添加约束，这里添加行约束
                switch (rowNum) {
                    case 1:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.1f);
                        keyView.backgroundColor = [UIColor colorWithRed:205 green:205 blue:205 alpha:1];
                    }
                        break;
                    case 2:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.3f);
                    }
                        break;
                    case 3:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.5f);
                    }
                        break;
                    case 4:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.7f);
                    }
                        break;
                    case 5:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.9f);
                    }
                        break;
                    default:
                        break;
                }
                //按照行和列添加约束，这里添加列约束
                switch (colNum) {
                    case 1:
                    {
                        make.left.equalTo(keyboardView.mas_left);
                    }
                        break;
                    case 2:
                    {
                        make.right.equalTo(keyboardView.mas_centerX);
                    }
                        break;
                    case 3:
                    {
                        make.left.equalTo(keyboardView.mas_centerX);
                    }
                        break;
                    case 4:
                    {
                        make.right.equalTo(keyboardView.mas_right);
                        [keyView setBackgroundColor:[UIColor colorWithRed:243 green:127 blue:38 alpha:1]];
                    }
                        break;
                    default:
                        break;
                }
            }
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
