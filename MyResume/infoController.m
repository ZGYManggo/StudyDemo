//
//  infoController.m
//  MyResume
//
//  Created by jiemo on 15/12/1.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import "infoController.h"
#import "DBManager.h"
@interface infoController ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *sex;

@property (weak, nonatomic) IBOutlet UILabel *brithday;
@property (weak, nonatomic) IBOutlet UILabel *school;
@property (weak, nonatomic) IBOutlet UILabel *zhuanye;
@property (weak, nonatomic) IBOutlet UILabel *afterschooltime;
@property (weak, nonatomic) IBOutlet UILabel *jiguan;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *phonenumber;

@property (weak, nonatomic) IBOutlet UILabel *age;
@property (nonatomic,copy) NSString *plistPath;
@end

@implementation infoController
-(NSString *)plistPath{
    if (!_plistPath) {
        
        // 获取document目录
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        _plistPath = [doc stringByAppendingPathComponent:@"Myinfo.archiver"];
    }
    
    return _plistPath;
    
}
-(void)viewWillAppear:(BOOL)animated{
  [self readMyinfo];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *brithdate = [formatter dateFromString:self.brithday.text];
   NSString *currentDateStr = [formatter stringFromDate:[NSDate date]]; NSDate *currentDate = [formatter dateFromString:currentDateStr];
    NSTimeInterval time=[currentDate timeIntervalSinceDate:brithdate];
    int age = ((int)time)/(3600*24*365);
    self.age.text=[NSString stringWithFormat:@"%d岁",age];
}
-(void)viewDidAppear:(BOOL)animated{
 [self.tableView reloadData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)readMyinfo{
    DBManager *myInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:self.plistPath];
        self.name.text=myInfo.name;
        self.sex.text=myInfo.sex;
        self.brithday.text=myInfo.brithday;
        self.school.text=myInfo.school;
        self.zhuanye.text=myInfo.zhuanye;
        self.afterschooltime.text=myInfo.afterschooltime;
        self.location.text=myInfo.location;
        self.jiguan.text=myInfo.jiguan;
        self.phonenumber.text=myInfo.phonenumber;
    
    
}



@end
