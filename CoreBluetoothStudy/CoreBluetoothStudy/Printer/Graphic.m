//
//  Graphic.m
//  BLETR
//
//  Created by JQTEK on 15/3/31.
//  Copyright (c) 2015年 ISSC. All rights reserved.
//

#import "Graphic.h"

@implementation Graphic

-(BOOL)linedrawOut:(int)startPoint endPoint:(int)endPoint
{
    [self.printInfo.wrap addByte:0x1D];
    [self.printInfo.wrap addByte:0x27];
    [self.printInfo.wrap addByte:0x01];

    [self.printInfo.wrap  addShort:startPoint];
    return [self.printInfo.wrap  addShort:endPoint];
}

- (BOOL)lineDrawOutX:(int)x Y:(int)y{
    if (x < 0 || x >= self.printInfo.escPageWidth || x > 0x1FF) {
        return FALSE;
    }
    
    if (y < 0 || y >= self.printInfo.escPageHeight || y > 0x7F) {
        return FALSE;
    }
    
    ushort pos = ((x & 0x1FF) | ((y & 0x7F) << 9));
    [self.printInfo.wrap addByte:0x1D];
    [self.printInfo.wrap addByte:0x27];
    [self.printInfo.wrap addByte:0x01];

    return [self.printInfo.wrap addShort:pos];
}

@end
