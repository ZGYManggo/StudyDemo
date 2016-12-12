//
//  FontLabel.m
//  ChangeTextFont
//
//  Created by jiemo on 16/12/12.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "FontLabel.h"

NSString *const ZGFontChange = @"ZGFontChange";
NSString *const ZGFont = @"ZGFont";

@implementation FontLabel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
        [notification addObserver:self selector:@selector(fontChange:) name:ZGFontChange object:nil];
    }
    return self;
}

- (void)fontChange:(NSNotification *)notification{
    self.font = [UIFont fontWithName:[[NSUserDefaults standardUserDefaults] objectForKey:ZGFont] size:16.f];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
