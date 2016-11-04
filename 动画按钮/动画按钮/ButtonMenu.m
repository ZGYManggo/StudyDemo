//
//  ButtonMenu.m
//  动画按钮
//
//  Created by jiemo on 15/11/5.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import "ButtonMenu.h"
@interface ButtonMenu()
@property (weak, nonatomic) IBOutlet UIButton *mainmenu;
@property(nonatomic,strong) NSMutableArray *arrayWithButton;
@end
@implementation ButtonMenu
-(NSMutableArray *)arrayWithButton{
    if(!_arrayWithButton){
        _arrayWithButton=[NSMutableArray array];
    }
    return _arrayWithButton;

}
+(instancetype)ButtonMenu{

    return [[[NSBundle mainBundle] loadNibNamed:@"ButtonMenu" owner:nil options:nil]lastObject];

}
#pragma mark 对象是从xib/storybard加载的时候，就会调用这个方法
-(id)initWithCoder:(NSCoder *)aDecoder{
    NSLog(@"%s",__func__);
    if(self = [super initWithCoder:aDecoder ]){
        [self initItems];
    }
    
    return self;
}
-(void)initItems{

     [self buttonWithimage:@"menu_btn_call" tag:0];
    [self buttonWithimage:@"menu_btn_cheyou" tag:1];
     [self buttonWithimage:@"menu_btn_tixing" tag:2];
    

}
-(void)buttonWithimage:(NSString *)imageName tag:(NSInteger)tag{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    btn.tag=tag;
    [self.arrayWithButton addObject:btn];
  //  NSLog(@"%@",self.arrayWithButton);
    [self addSubview:btn];
    

}
-(void)layoutSubviews{
      NSLog(@"%@",self.mainmenu);
    [super layoutSubviews];
    CGRect btnBounds = CGRectMake(0, 0, 43, 43);
    for (UIButton *button in self.arrayWithButton) {
        button.center=self.mainmenu.center;
        button.bounds=btnBounds;
    }
    [self bringSubviewToFront:self.mainmenu];
}
- (IBAction)clik:(UIButton *)sender {
    BOOL flag=CGAffineTransformIsIdentity(self.mainmenu.transform);
    [UIView animateWithDuration:1.0 animations:^{
        if(flag){
            self.mainmenu.transform = CGAffineTransformMakeRotation(M_PI_4);
            [self btnWithAnimation:flag];
        }
        else{
            self.mainmenu.transform=CGAffineTransformIdentity;
            [self btnWithAnimation:flag];
        
        }
    }];
  

}

-(void)btnWithAnimation:(BOOL)flag{
    for (UIButton *btn in self.arrayWithButton) {
        CGFloat y=btn.center.y;
        CGFloat x=self.mainmenu.center.x + (btn.tag + 1) * 90;
        NSValue *value0=[NSValue valueWithCGPoint:self.mainmenu.center];
        NSValue *value1=[NSValue valueWithCGPoint:CGPointMake(x, y)];
        if (flag) {
            btn.center=CGPointMake(x, y);
           [self animation:value0 to:value1 withbtn:btn];
            
        }else{
            btn.center=self.mainmenu.center;
        [self animation:value1 to:value0 withbtn:btn];
            
        }
        
    }

}
-(void)animation:(NSValue *)from to:(NSValue *)to withbtn:(UIButton *)btn{
    CAAnimationGroup *group=[CAAnimationGroup animation];
    CAKeyframeAnimation *rotation=[CAKeyframeAnimation animation];
    CABasicAnimation *animation=[CABasicAnimation animation];
    animation.fromValue=from;
    animation.toValue=to;
    animation.keyPath=@"position";
    rotation.keyPath=@"transform.rotation";
    rotation.values=@[@0,@(M_PI*4)];
    group.duration=1.0;
    group.animations=@[animation,rotation];
    [btn.layer addAnimation:group forKey:nil];
    
}
@end
