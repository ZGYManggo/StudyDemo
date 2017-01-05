//
//  MyPeripheral.h
//  CoreBluetoothStudy
//
//  Created by jiemo on 17/1/3.
//  Copyright © 2017年 张高远. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
typedef NS_ENUM(NSInteger,connectStaus){
    CONNECT_STATUS_DEFAULT = 0,
    CONNECT_STATUS_CONNECTING,
    CONNECT_STATUS_CONNECTED,
};
@interface MyPeripheral : NSObject
@property (nonatomic,strong) CBPeripheral *peripheral;
@property (nonatomic,assign) connectStaus connectStaus;

@end
