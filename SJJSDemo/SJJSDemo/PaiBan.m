//
//  PaiBan.m
//  SJJSDemo
//
//  Created by jiemo on 15/10/31.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import "PaiBan.h"
@interface PaiBan()
@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,assign)CGPoint lastpoint;
@end
@implementation PaiBan


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *path=[UIBezierPath bezierPath];
    NSInteger count= self.array.count;
    if(count==0) return;
    for (NSInteger i=0; i<count; i++) {
        CGPoint point=[self.array[i] center];
        if(i==0){
            [path moveToPoint:point];
        }else{
            [path addLineToPoint:point];
        }
    }
    [path addLineToPoint:self.lastpoint];
    [path setLineWidth:8.0];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapRound];
    [[UIColor greenColor] set];
    [path stroke];
    
    
}

-(NSMutableArray *)array{
    if(!_array){
        _array=[NSMutableArray array];
    }
    return _array;

}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        for (NSInteger i=0; i<9; i++) {
            UIButton *button = [[UIButton alloc]init];
            [button setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
            button.tag=i;
            button.userInteractionEnabled=NO;
            [self addSubview:button];
        }
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //重新布局9个按钮
    
    CGFloat btnW = 60;
    CGFloat btnH = 60;
    NSInteger btnCount = self.subviews.count;
    
    // 每一个按钮的间距
    CGFloat padding = (self.frame.size.width - 3 * btnW) / 4;
    
    for (NSInteger i = 0; i < btnCount; i++) {
        UIButton *btn = self.subviews[i];
        
        // 当前按钮所处的列
        NSInteger column = i % 3;
        
        // 当前按钮所处的行
        NSInteger row = i / 3;
        
        // 计算每一个按钮的位置
        // x = 间距 + （按钮的宽度 + 间距） * 列
        CGFloat btnX = padding + (btnW + padding) * column;
        
        // y = 间距 + （按钮的高度 + 间距） * 行
        CGFloat btnY = padding + (btnH + padding) * row;
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
    }

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self touchesMoved:touches withEvent:event];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint touchP = [touch locationInView:touch.view];
    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame,touchP )) {
            if (btn.selected==NO) {
                [self.array addObject:btn];
            }
            btn.selected=YES;
            
        }else{
            self.lastpoint=touchP;
        }
    }
    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSMutableString *password = [NSMutableString string];
    for (UIButton *seletedBtn in self.array) {
        [password appendFormat:@"%ld",seletedBtn.tag];
    }
    if ([self.delegate respondsToSelector:@selector(lockView:didSeletedPassowrd:)]) {
        [self.delegate lockView:self didSeletedPassowrd:password];
    }
    for (UIButton *button in self.subviews) {
        button.selected=NO;
    }
    [self.array removeAllObjects];
    
    // 重绘
    [self setNeedsDisplay];
}
@end
