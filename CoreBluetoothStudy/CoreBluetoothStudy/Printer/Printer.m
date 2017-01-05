//
//  Printer.m
//  BLETR
//
//  Created by JQTEK on 15/3/30.
//  Copyright (c) 2015年 ISSC. All rights reserved.
//

#import "Printer.h"
#import "ESC.h"

@implementation Printer
@synthesize esc;
@synthesize port;
@synthesize printerInfo;
@synthesize sendFlag;
@synthesize sendFinish;
@synthesize jpl;

-(id)init{
    self=[super init];
    if(self){
        port = nil;
        wrap = [[WrapDatas alloc]init];
        printerInfo = [[PrinterInfo alloc]init];
        printerInfo.model = VMP02_P;
        printerInfo.wrap = wrap;
        
        esc = [[ESC alloc]init];
        esc.printInfo = printerInfo;
        
        jpl = [[JPL alloc]init];
        jpl.printInfo = printerInfo;
        
        sendFlag = FALSE;
        sendFinish = FALSE;
        
    }
    return self;
}

-(void)dealloc{
//    [esc dealloc];
//    [jpl dealloc];
//    [printerInfo dealloc];
//    [wrap dealloc];
//    [super dealloc];
}

-(void) setPort:(MyPeripheral *) value{
    if (port == value) {
        return;
    }
//    port.deviceInfoDelegate=self;
//    port.proprietaryDelegate=self;
    if (port != nil) {
//        [port release];
    }
    port = value;
    esc.port = port;
    jpl.port = port;
}

- (void)MyPeripheral:(MyPeripheral *)peripheral didUpdateTransDataNotifyStatus:(BOOL)notify{
    //    NSLog(@"DataTransparentViewController] didUpdateTransDataNotifyStatus = %@",notify==true?@"true":@"false");
}

- (void)MyPeripheral:(MyPeripheral *)peripheral didUpdateHardwareRevision:(NSString *)hardwareRevision error:(NSError *)error {
    //    if (!error) {
    //        NSLog(@"Hardware = %@",hardwareRevision);
    //        _hardwareRevision = [hardwareRevision retain];
    //        if ([hardwareRevision hasPrefix:[NSString stringFromHexString:BM77SPP_HW]]) {
    //            //BM77SPP
    //            [connectedPeripheral readFirmwareRevision];
    //        }
    //        else if ([hardwareRevision hasPrefix:[NSString stringFromHexString:BLETR_HW]]) {
    //            //BLETR
    //            [connectedPeripheral readFirmwareRevision];
    //        }
    //        else {
    //            isPatch = YES;
    //            [connectedPeripheral setTransDataNotification:TRUE];
    //        }
    //    }
    
}

- (void)MyPeripheral:(MyPeripheral *)peripheral didUpdateFirmwareRevision:(NSString *)firmwareRevision error:(NSError *)error {
    //    if (!error) {
    //        NSLog(@"firmwareRevision = %@",firmwareRevision);
    //        _firmwareRevision = [firmwareRevision retain];
    //        if ([firmwareRevision hasPrefix:[NSString stringFromHexString:BM77SPP_FW]]) {
    //            //BM77SPP
    //            [connectedPeripheral readMemoryValue:BM77SPP_AD length:2];
    //        }
    //        else if ([firmwareRevision hasPrefix:[NSString stringFromHexString:BLETR_FW]]) {
    //            //BLETR
    //            [connectedPeripheral readMemoryValue:BLETR_AD length:2];
    //        }
    //        else {
    //            isPatch = YES;
    //            [connectedPeripheral setTransDataNotification:TRUE];
    //        }
    //    }
    
}

- (void)MyPeripheral:(MyPeripheral *)peripheral didReceiveMemoryAddress:(NSData *)address length:(short)length data:(NSData *)data {
    //    NSLog(@"%@ = %@",address,data);
    //    _writeTypeLabel.text = [NSString stringWithFormat:@"Address %@ = %@",address,data];
    //    unsigned short int add;
    //    [address getBytes:&add length:2];
    //    add = NSSwapBigShortToHost(add);
    //    unsigned short int d;
    //    [data getBytes:&d length:length];
    //    d = NSSwapBigShortToHost(d);
    //    if ([_hardwareRevision hasPrefix:[NSString stringFromHexString:BM77SPP_HW]] && [_firmwareRevision hasPrefix:[NSString stringFromHexString:BM77SPP_FW]] && add == BM77SPP_AD) {
    //        if (d != 0x0017) {
    //            char w[2];
    //            w[0] = 0x00;
    //            w[1] = 0x17;
    //            [connectedPeripheral writeMemoryValue:BM77SPP_AD length:2 data:w];
    //        }
    //        else {
    //            isPatch = YES;
    //            [connectedPeripheral setTransDataNotification:TRUE];
    //        }
    //    }
    //    else if ([_hardwareRevision hasPrefix:[NSString stringFromHexString:BLETR_HW]] && [_firmwareRevision hasPrefix:[NSString stringFromHexString:BLETR_FW]] && add == BLETR_AD) {
    //        if (d != 0x17) {
    //            char w[2];
    //            w[0] = 0x00;
    //            w[1] = 0x17;
    //            [connectedPeripheral writeMemoryValue:BLETR_AD length:2 data:w];
    //        }
    //        else {
    //            isPatch = YES;
    //            [connectedPeripheral setTransDataNotification:TRUE];
    //        }
    //    }
}

- (void)MyPeripheral:(MyPeripheral *)peripheral didWriteMemoryAddress:(NSError *)error {
    //    if (!error) {
    //        isPatch = YES;
    //        [connectedPeripheral setTransDataNotification:TRUE];
    //    }
}

//- (void)reliableBurstData:(ReliableBurstData *)reliableBurstData didSendDataWithCharacteristic:(CBCharacteristic *)transparentDataWriteChar {
//    //    int segmentIndex = [self.segmentedControl selectedSegmentIndex];
//    //    if (segmentIndex == CBLoopBackMode) {
//    //        [self sendLoopBackData];
//    //    }
//    //    else if (txPath) {
//    //        [self writeFile];
//    //    }
//}


@end
