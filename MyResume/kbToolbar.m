//
//  kbToolbar.m
//  MyResume
//
//  Created by jiemo on 15/12/2.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import "kbToolbar.h"

@implementation kbToolbar

+(instancetype)kbToolbar{
    kbToolbar *bar=[[[NSBundle mainBundle] loadNibNamed:@"kbToolbar" owner:nil options:nil] lastObject];
    bar.bounds=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    return bar;
}
- (IBAction)ItemClick:(UIBarButtonItem *)sender {
    if ([self.kbdelegate respondsToSelector:@selector(keyboardToolbar:btndidSelected:)]) {
        [self.kbdelegate keyboardToolbar:self btndidSelected:sender];
    }
}
@end
