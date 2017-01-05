//
//  JPLBase.h
//  BLETR
//
//  Created by JQTEK on 15/4/15.
//  Copyright (c) 2015年 ISSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "PrinterType.h"
#import "MyPeripheral.h"
#import "PrinterInfo.h"

@interface JPLBase : NSObject

@property (retain) MyPeripheral* port;
@property (retain) PrinterInfo* printInfo;
@property (assign) Byte *buffer;



@end
