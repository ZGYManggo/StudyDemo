//
//  ChangeInfoController.m
//  MyResume
//
//  Created by jiemo on 15/12/1.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import "ChangeInfoController.h"

@interface ChangeInfoController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *sex;

@property (weak, nonatomic) IBOutlet UITextField *brithday;
@property (weak, nonatomic) IBOutlet UITextField *school;
@property (weak, nonatomic) IBOutlet UITextField *zhuanye;
@property (weak, nonatomic) IBOutlet UITextField *afterschooltime;
@property (weak, nonatomic) IBOutlet UITextField *jiguan;
@property (weak, nonatomic) IBOutlet UITextField *location;
@property (weak, nonatomic) IBOutlet UITextField *phonenumber;
@property(nonatomic,strong) NSArray  *fields;
@property(nonatomic,strong) kbToolbar *bar;

@property (nonatomic,copy) NSString *plistPath;
@end


@implementation ChangeInfoController
-(NSArray *)fields{
    if (!_fields) {
        _fields=[NSArray arrayWithObjects:self.name, self.sex,self.brithday,self.school,self.zhuanye,self.afterschooltime,self.jiguan,self.location ,self.phonenumber,nil];
    }

    return _fields;
}
-(NSString *)plistPath{
    if (!_plistPath) {
        
        // 获取document目录
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        _plistPath = [doc stringByAppendingPathComponent:@"Myinfo.archiver"];
    }
    
    return _plistPath;
    
}
-(kbToolbar *)bar{
    if(!_bar){
     _bar=[kbToolbar kbToolbar];
        
    }
    return _bar;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readMyinfo];
    [self addkbBar];
    [self datekb];
    self.bar.kbdelegate=self;
    //监听键盘事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHide) name:UIKeyboardWillHideNotification object:nil];
   
}
-(void)willShow:(NSNotification *)notifi{
   
    
    //当键盘挡住UITextField，TextField所在父控件往上移
    
    //1.获取当前选中的UITextField在控制器view的最大Y值
    //当前获取焦点的textfield
    UITextField *currentTf = self.fields[[self indexOfFirstResponder]];
    
    //键盘一弹出，就判断上一个，下一个按钮可不可用
    if(currentTf.tag == 0){
        self.bar.previousItem.enabled = NO;
    }
    
    if(currentTf.tag == self.fields.count - 1){
        self.bar.nextItem.enabled = NO;
    }
    
//    //currentTf.frame.origin.y +  currentTf.frame.size.height
//    CGFloat maxY = CGRectGetMaxY(currentTf.frame) + self.registerContainer.frame.origin.y;
//    
//    
//    //2.获取键盘的y值
//    CGRect kbEndFrm = [notifi.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat kbY = kbEndFrm.origin.y;
//    
//    //3.进行比较
//    //计算距离
//    CGFloat delta = kbY - maxY;
//    if(delta < 0){//需要往上移
//        //添加个动画
//        [UIView animateWithDuration:0.25 animations:^{
//            self.view.transform = CGAffineTransformMakeTranslation(0, delta);
//        }];
//        
//    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
}
-(void)willHide{

    
    
    //    //还原工具条的item为可用
    self.bar.previousItem.enabled = YES;
    self.bar.nextItem.enabled = YES;
    
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
-(void)datekb{
    UIDatePicker *datepicker=[[UIDatePicker alloc]init];
    datepicker.datePickerMode=UIDatePickerModeDate;
    UIDatePicker *datepicker2=[[UIDatePicker alloc]init];
    datepicker2.datePickerMode=UIDatePickerModeDate;
    [datepicker addTarget:self action:@selector(datePickerChange:) forControlEvents:UIControlEventValueChanged];
    [datepicker2 addTarget:self action:@selector(datePickerChange2:) forControlEvents:UIControlEventValueChanged];
    self.brithday.inputView=datepicker;
    self.afterschooltime.inputView=datepicker2;
    
    UIPickerView *sexPicker=[[UIPickerView alloc ]init];
    sexPicker.delegate=self;
    sexPicker.dataSource=self;
    self.sex.inputView=sexPicker;
}
-(void)addkbBar{
    self.brithday.inputAccessoryView=self.bar;
     self.name.inputAccessoryView=self.bar;
     self.school.inputAccessoryView=self.bar;
     self.sex.inputAccessoryView=self.bar;
     self.zhuanye.inputAccessoryView=self.bar;
     self.location.inputAccessoryView=self.bar;
     self.phonenumber.inputAccessoryView=self.bar;
     self.jiguan.inputAccessoryView=self.bar;
    self.afterschooltime.inputAccessoryView=self.bar;

}
-(void)keyboardToolbar:(kbToolbar *)toolbar btndidSelected:(UIBarButtonItem *)item{
    DBManager  *myinfo=[DBManager shareInstance];
    switch (item.tag) {
        case 0://上一个
            [self previous];
            break;
        case 1://下一个
            [self next];
            break;
        case 2://完成
            myinfo.name=self.name.text;
            myinfo.sex=self.sex.text;
            myinfo.brithday=self.brithday.text;
            myinfo.school=self.school.text;
            myinfo.zhuanye=self.zhuanye.text;
            myinfo.afterschooltime=self.afterschooltime.text;
            myinfo.jiguan=self.jiguan.text;
            myinfo.location=self.location.text;
            myinfo.phonenumber=self.phonenumber.text;
            [self.view endEditing:YES];
            break;
            
        default:
            break;
    }

}

- (void) datePickerChange:(id) sender {
    if ([sender isKindOfClass:[UIDatePicker class]]) {
        UIDatePicker * datePicker = sender;
        
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString * dateString = [formatter stringFromDate:datePicker.date];
        self.brithday.text=dateString;
        
    }
}
- (void) datePickerChange2:(id) sender {
    if ([sender isKindOfClass:[UIDatePicker class]]) {
        UIDatePicker * datePicker = sender;
        
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString * dateString = [formatter stringFromDate:datePicker.date];
        self.afterschooltime.text=dateString;
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    DBManager  *myinfo=[DBManager shareInstance];
    myinfo.name=self.name.text;
    myinfo.sex=self.sex.text;
    myinfo.brithday=self.brithday.text;
    myinfo.school=self.school.text;
    myinfo.zhuanye=self.zhuanye.text;
    myinfo.afterschooltime=self.afterschooltime.text;
    myinfo.jiguan=self.jiguan.text;
    myinfo.location=self.location.text;
    myinfo.phonenumber=self.phonenumber.text;
    [self.view endEditing:YES];

}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
       return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 2;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (row==0) {
        return @"男";
    }
    return @"女";
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (row==0) {
        self.sex.text=@"男";
    }else{
        self.sex.text=@"女";
    }
}

-(NSInteger)indexOfFirstResponder{
    
    for (UITextField *tf in self.fields) {
        if (tf.isFirstResponder) {
            
            return tf.tag;
        }
    }
    
    //返回一1没有当前响应者
    return -1;
}
-(void)previous{
    //获取当前焦点
    NSInteger currentIndex = [self indexOfFirstResponder];
    
    self.bar.nextItem.enabled = YES;
    //    if(currentIndex == 1){
    //        //禁止上一个按钮
    //        self.toolbar.previousItem.enabled = NO;
    //    }
    //
    //获取上一个索引
    NSInteger previouesIndex = currentIndex - 1;
    
    //不当响应者
    [self.fields[currentIndex] resignFirstResponder];
    
    //索引要大于等0
    if (previouesIndex >= 0) {
        
        [self.fields[previouesIndex] becomeFirstResponder];
    }
    
    
    
    
}
-(void)next{
    //获取当前焦点
    NSInteger currentIndex = [self indexOfFirstResponder];
    
    self.bar.previousItem.enabled = YES;
    
    //    //判断当前索引等于什么的时候，下个按钮不可以？
    //    if (currentIndex == self.fields.count - 2) {
    //        self.toolbar.nextItem.enabled = NO;
    //    }
    
    //不当响应者
    [self.fields[currentIndex] resignFirstResponder];
    
    //设置下一个焦点
    if (currentIndex != -1 && currentIndex != self.fields.count -1) {
        NSInteger nextIndex = currentIndex + 1;
        [self.fields[nextIndex] becomeFirstResponder];
    }
}
@end
