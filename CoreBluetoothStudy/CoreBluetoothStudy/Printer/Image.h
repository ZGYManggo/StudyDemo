//
//  Image.h
//  BLETR
//
//  Created by JQTEK on 15/3/30.
//  Copyright (c) 2015年 ISSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "MyPeripheral.h"
#import "PrinterInfo.h"
#import "ESCBase.h"
#import "Image.h"
#import "ImageConvert.h"

typedef NS_ENUM(Byte, IMAGE_MODE)
{
    SINGLE_WIDTH_8_HEIGHT=(0x01),
    DOUBLE_WIDTH_8_HEIGHT=(0x00),
    SINGLE_WIDTH_24_HEIGHT=(0x21),
    DOUBLE_WIDTH_24_HEIGHT=(0x20),
};


typedef NS_ENUM(Byte, IMAGE_ENLARGE)
{
    IMAGE_ENLARGE_NORMAL,
    IMAGE_ENLARGE_HEIGHT_DOUBLE,
    IMAGE_ENLARGE_WIDTH_DOUBLE,
    IMAGE_ENLARGE_HEIGHT_WIDTH_DOUBLE
};

@interface Image : ESCBase{
    Byte*cmd;
    
}

-(BOOL) printOut:(int)x width:(int)width height:(int)height mode:(IMAGE_MODE)mode data:(Byte*)data dataLength:(int)dataLength sleepTime:(int)sleepTime;

-(BOOL) printOutOneLine:(Byte*)data dataLength:(int)dataLenght;
-(BOOL) drawOut:(int)x y:(int)y imageWidthDots:(int)imageWidthDots imageHeightDots:(int)imageHeightDots mode:(IMAGE_ENLARGE)mode imageData:(Byte*)imageData;
-(BOOL)drawOut:(int)x y:(int)y bitmap:(UIImage*)bitmap;

@end
