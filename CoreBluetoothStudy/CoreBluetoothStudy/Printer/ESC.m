//
//  ESC.m
//  BLETR
//
//  Created by JQTEK on 15/3/30.
//  Copyright (c) 2015年 ISSC. All rights reserved.
//

#import "ESC.h"

@implementation ESC
@synthesize port;
@synthesize printInfo;
@synthesize text;
@synthesize image;
@synthesize barcode;
@synthesize grahic;

// 构造函数
-(id)init{
    self = [super init];
    if (self) {
        text=[[Text alloc]init];
        image = [[Image alloc] init];
        barcode = [[Barcode alloc]init];
        grahic = [[Graphic alloc]init];
    }
    return self;
}

//设置端口
-(void) setPort:(MyPeripheral *) value{
    if (port == value) return;
    if (port != nil) {
    }
    port = value;
    text.port = port;
    image.port = port;
    barcode.port = port;
    grahic.port = port;
}

//设置相关参数
-(void) setPrintInfo:(PrinterInfo *) value{
    if (printInfo == value) return;
    if (printInfo != nil) {
//        [printInfo release];
   }
    
    printInfo = value;
    text.printInfo = printInfo;
    image.printInfo = printInfo;
    barcode.printInfo = printInfo;
    grahic.printInfo = printInfo;
}

- (void)dealloc {
//    [text dealloc];
//    [image dealloc];
//    [barcode dealloc];
//    [grahic dealloc];    
}

//唤醒打印机
-(BOOL)wakeUp{
    if(![self.printInfo.wrap addByte:0x00]) return FALSE;
    [NSThread sleepForTimeInterval:50];
    return [self restorePrinter];
}


//走纸n行
-(BOOL)feedLines:(int)lines{
    [self.printInfo.wrap addByte:0x1B];
    [self.printInfo.wrap addByte:0x64];
    return [self.printInfo.wrap addByte:(Byte)lines];
}

//走纸n点
-(BOOL)feedDots:(int)dots{
    [self.printInfo.wrap addByte:0x1B];
    [self.printInfo.wrap addByte:0x4A];
    return [self.printInfo.wrap addByte:(Byte)dots];
}

@end

