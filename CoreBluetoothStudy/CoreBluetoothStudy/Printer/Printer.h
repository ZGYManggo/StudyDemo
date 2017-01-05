//
//  Printer.h
//  BLETR
//
//  Created by JQTEK on 15/3/30.
//  Copyright (c) 2015年 ISSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESC.h"
#import "JPL.h"
#import "PrinterInfo.h"

@interface Printer : NSObject/*<MyPeripheralDelegate>*/{
    WrapDatas *wrap;
}
@property(retain)ESC * esc;
@property(retain)JPL * jpl;
@property(nonatomic,copy)MyPeripheral * port;
@property(nonatomic,copy)PrinterInfo* printerInfo;
@property(assign) BOOL sendFlag;
@property(assign) BOOL sendFinish;





@end
