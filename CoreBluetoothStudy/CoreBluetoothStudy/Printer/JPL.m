//
//  JPL.m
//  BLETR
//
//  Created by JQTEK on 15/4/15.
//  Copyright (c) 2015年 ISSC. All rights reserved.
//

#import "JPL.h"

@implementation JPL
@synthesize port;
@synthesize printInfo;
@synthesize text;
@synthesize page;
@synthesize image;
@synthesize barcode;
@synthesize grahic;

// 构造函数
-(id)init{
    self = [super init];
    if (self) {
        text=[[JPLText alloc]init];
        page=[[Page alloc]init];
        image=[[JPLImage alloc]init];
        barcode=[[JPLBarcode alloc]init];
        grahic = [[JPLGraphic alloc]init];
    }
    return self;
}

//设置端口
-(void) setPort:(MyPeripheral *) value{
    if (port == value) return;
    if (port != nil) {
//        [port release];
    }
    port = value;
    text.port = port;
    page.port = port;
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
    page.printInfo = printInfo;
    image.printInfo = printInfo;
    barcode.printInfo=printInfo;
    grahic.printInfo = printInfo;
}

- (void)dealloc {
//    [text dealloc];
//    [page dealloc];
//    [image dealloc];
//    [barcode dealloc];
//    [grahic dealloc];
//    [super dealloc];
    
}

/*
 * 走纸到下一张标签开始
 */
-(BOOL)feedNextLabelBegin
{
    [self.printInfo.wrap addByte:0x1A];
    [self.printInfo.wrap addByte:0x0C];
    return [self.printInfo.wrap addByte:0x00];
}

-(BOOL)feed:(FEED_TYPE)feed_type offset:(int)offset
{
    [self.printInfo.wrap addByte:0x1A];
    [self.printInfo.wrap addByte:0x0C];
    [self.printInfo.wrap addByte:(Byte)feed_type];
    return [self.printInfo.wrap addShort:(short)offset];
}
/*
 * 打印纸后退
 * 注意:1.需要打印机JLP351的固件版本3.0.0.0及以上
 *      2.需要设置软件设置打印机，使能FeedBack状态
 */
-(BOOL)feedBack:(int)dots
{
    return [self feed:BACK offset:dots];
}

-(BOOL)feedNextLabelEnd:(int)dots
{
    return [self feed:LABEL_END offset:dots];
}

-(BOOL)feedMarkOrGap:(int)dots
{
    return [self feed:MARK_OR_GAP offset:dots];
}

-(BOOL)feedMarkEnd:(int)dots
{
    return [self feed:MARK_END offset:dots];
}

-(BOOL)feedMarkBegin:(int)dots
{
    return [self feed:MARK_BEGIN offset:dots];
}


@end
