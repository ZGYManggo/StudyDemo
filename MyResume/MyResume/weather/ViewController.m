//
//  ViewController.m
//  weatherWithUrlSeesion
//
//  Created by jiemo on 15/11/24.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *allView;

@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *wt;

@property (weak, nonatomic) IBOutlet UILabel *currentTEM;

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *high;
@property(nonatomic,copy) NSMutableString *falg;
@property(nonatomic,assign)NSInteger number;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@end

@implementation ViewController
-(NSInteger)number{
     
    if (_number==10) {
        _number=0;
    }
    _number++;
    return _number;
}
-(void)viewDidDisappear:(BOOL)animated{
    if ([AppStatus shareInstance].contextStr) {
        self.falg=[NSMutableString stringWithString:[AppStatus shareInstance].contextStr];
    }

}
-(void)viewWillAppear:(BOOL)animated{
    if (![self.falg isEqualToString:[AppStatus shareInstance].contextStr]) {

    self.wt.alpha=0;
    self.icon.alpha=0;
        self.allView.alpha=0;
    }
}
-(void)viewDidAppear:(BOOL)animated{
    if (![self.falg isEqualToString:[AppStatus shareInstance].contextStr]) {
        NSMutableString *URLTmpp = [[NSMutableString alloc]initWithString:@"http://api.k780.com:88/?app=weather.today&weaid=&appkey=16568&sign=726e59c3902e5898a65f130ce0b8a2f4&format=json"];
        if([AppStatus shareInstance].contextStr){
            [URLTmpp insertString:[AppStatus shareInstance].contextStr atIndex:48];
        }
        
        
        [self getWeather:URLTmpp];
    }
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    //隐藏了navigationbar后手势返回失效，可以调用此方法，让手势返回生效
   // self.navigationController.interactivePopGestureRecognizer.delegate = (id) self;
    //添加返回手势
    UIScreenEdgePanGestureRecognizer *gesture=[[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(can)];
    gesture.edges=UIRectEdgeLeft;
    [self.view addGestureRecognizer:gesture];
    [self changeBackground];
    self.scrollview.contentSize = CGSizeMake(self.scrollview.frame.size.width,self.scrollview.frame.size.height*1.5);
    [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(changeBackground) userInfo:nil repeats:YES];
    
  
   

}

-(void)changeBackground{
    CATransition *transition=[CATransition animation];
    transition.type=@"kCATransitionMoveIn";
    //transition.subtype=@"fromRight";
    transition.duration=1.5;

    NSString *imageName=[NSString stringWithFormat:@"00%ld-StockPhotos",self.number-1];
   self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
    [self.view.layer addAnimation:transition forKey:nil];
}
-(void)viewAnimation{
    [UIView animateWithDuration:1.0f animations:^{
        self.allView.alpha=1;
        CATransition *transition=[CATransition animation];
        transition.type=@"kCATransitionFade";
        transition.duration=1;
        [self.allView.layer addAnimation:transition forKey:nil];
    }];
    
}

-(void)getWeather:(NSString *)url1{
    
    NSString *URLTmp = [[NSString stringWithString:url1]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url=[NSURL URLWithString:URLTmp ];
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        
      //  NSString *flag=[NSString stringWithString:dic[@"success"]];
        
        NSDictionary *dic1=[NSDictionary dictionaryWithDictionary:dic[@"result"]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            if ([dic[@"success"] isEqual:@"0"]) {
                self.city.text=@"未收录地点";
                return;
            }
            self.city.text=dic1[@"citynm"];
            self.currentTEM.text=dic1[@"temperature_curr"];
            self.icon.image=[UIImage imageNamed:dic1[@"weather"]];
            self.wt.text=dic1[@"weather"];
            self.high.text=dic1[@"temperature"];
            //第一次动画开始
            [UIView animateWithDuration:1.5f animations:^{
                //天气动画
                CATransition *transition=[CATransition animation];
                transition.type=@"rippleEffect";
                transition.subtype=@"fromRight";
                transition.duration=1.5;
                self.icon.alpha=1;
                self.wt.alpha=1;
                self.icon.image=[UIImage imageNamed:dic1[@"weather"]];
                [self.wt.layer addAnimation:transition forKey:nil];
                [self.icon.layer addAnimation:transition forKey:nil];
                
            } completion:^(BOOL finished) {
              //  [self performSelector:@selector(viewAnimation) withObject:nil afterDelay:0.5f];
                [self viewAnimation];
            }];
            
            
        }];
    }];
    [task resume];


}
- (IBAction)can {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
