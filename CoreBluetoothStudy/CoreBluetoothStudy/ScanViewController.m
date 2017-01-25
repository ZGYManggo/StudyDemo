//
//  ScanViewController.m
//  CoreBluetoothStudy
//
//  Created by jiemo on 17/1/3.
//  Copyright © 2017年 张高远. All rights reserved.
//

#import "ScanViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "MyPeripheral.h"
#import "PrintViewController.h"

static NSString *const peripheralKey = @"peripheral";
@interface ScanViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate,UITableViewDataSource,UITableViewDelegate,PrintViewControllerDelegate>
{
    CBCentralManager *manager;
}

@property (nonatomic,strong) NSMutableArray *deviceArray;
@property (nonatomic,strong) NSMutableArray *connectedArray;
@property (nonatomic,strong) UITableView *thisTable;
@property (nonatomic,strong) CBCharacteristic *character;
@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.deviceArray = [NSMutableArray array];
    self.connectedArray = [NSMutableArray array];
    manager = [[CBCentralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue()];
    self.thisTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.thisTable.dataSource = self;
    self.thisTable.delegate = self;
    [self.view addSubview:self.thisTable];
    char* postData = "TEST";
    NSData* data = [NSData dataWithBytes:postData length:strlen(postData)];
    NSLog(@"%@", data);
    char* bu=(char *)[data bytes];
    NSLog(@"%s", bu);
    
}
//int main(){
//    FILE *fp;
//    char str[10000+1];
//    if( (fp=fopen("d:\\demo.txt","rt")) == NULL ){
//        printf("Cannot open file, press any key to exit!\n");
////        getch();
//        exit(1);
//    }
//    
//    while(fgets(str, 10000, fp) != NULL){
//        printf("%s", str);
//    }
//    fclose(fp);
//    system("pause");
//    return 0;
//}
- (void)storeMyPeripheral: (CBPeripheral *)aPeripheral {
    MyPeripheral *myPeripheral = nil;
    bool b = FALSE;
    for (int i = 0; i < [self.deviceArray count]; i++) {
        NSDictionary *dic = [self.deviceArray objectAtIndex:i];
        myPeripheral = dic[peripheralKey];
        if (myPeripheral.peripheral == aPeripheral) {
            b = TRUE;
            //NSLog(@"storeMyPeripheral 1");
            [self.deviceArray removeObject:dic];
            break;
        }
    }
    if(!b) {
        //NSLog(@"storeMyPeripheral 2");
        myPeripheral = [[MyPeripheral alloc] init];
        myPeripheral.peripheral = aPeripheral;
    }
    myPeripheral.connectStaus = CONNECT_STATUS_CONNECTED;
    [self.connectedArray addObject:myPeripheral];
    [self.thisTable reloadData];
}

#pragma mark - CBCentralManger

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    NSLog(@"%@",central);
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            NSLog(@"打开，可用");
            [manager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@(NO)}];
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@"可用，未打开");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@"SDK不支持");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@"程序未授权");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@"CBCentralManagerStateResetting");
            break;
        case CBCentralManagerStateUnknown:
            NSLog(@"CBCentralManagerStateUnknown");
            break;
    }
}
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    if (peripheral.name.length <= 0) {
        return ;
    }
    
    NSLog(@"Discovered name:%@,identifier:%@,advertisementData:%@,RSSI:%@", peripheral.name, peripheral.identifier,advertisementData,RSSI);
    if (self.deviceArray.count == 0) {
        MyPeripheral *temp = [MyPeripheral new];
        temp.peripheral = peripheral;
        NSDictionary *dict = @{peripheralKey:temp, @"RSSI":RSSI};
        [self.deviceArray addObject:dict];
    } else {
        BOOL isExist = NO;
        for (int i = 0; i < self.deviceArray.count; i++) {
            NSDictionary *dict = [self.deviceArray objectAtIndex:i];
            MyPeripheral *myPer = dict[peripheralKey];
            
            if ([myPer.peripheral.identifier.UUIDString isEqualToString:peripheral.identifier.UUIDString]) {
                isExist = YES;
                MyPeripheral *temp = [MyPeripheral new];
                temp.peripheral = peripheral;
                NSDictionary *dict = @{peripheralKey:temp, @"RSSI":RSSI};
                [_deviceArray replaceObjectAtIndex:i withObject:dict];
            }
        }
        
        if (!isExist) {
            MyPeripheral *temp = [MyPeripheral new];
            temp.peripheral = peripheral;
            NSDictionary *dict = @{peripheralKey:temp, @"RSSI":RSSI};
            [self.deviceArray addObject:dict];
        }
    }
    
    [self.thisTable reloadData];
}
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"didConnectPeripheral");
    // 连接成功后，查找服务
    [self storeMyPeripheral:peripheral];
    [peripheral discoverServices:nil];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    NSLog(@"didFailToConnectPeripheral");
}
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error{
    MyPeripheral *myPeripheral = nil;
    for (int i = 0; i < [self.deviceArray count]; i++) {
        NSDictionary *dic = [self.deviceArray objectAtIndex:i];
        myPeripheral = dic[peripheralKey];
        if (myPeripheral.peripheral == peripheral) {
            myPeripheral.connectStaus = CONNECT_STATUS_DEFAULT;
            break;
        }
    }
    for (int i = 0; i < [self.connectedArray count]; i++) {
        myPeripheral = [self.connectedArray objectAtIndex:i];
        if (myPeripheral.peripheral == peripheral) {
            [self.connectedArray removeObject:myPeripheral];
            break;
        }
    }
    [self.thisTable reloadData];
}
#pragma mark - CBPeripheralDelegate
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error
{
    NSString *UUID = [peripheral.identifier UUIDString];
    NSLog(@"didDiscoverServices:%@",UUID);
    if (error) {
        NSLog(@"出错");
        return;
    }
    
    CBUUID *cbUUID = [CBUUID UUIDWithString:UUID];
    NSLog(@"cbUUID:%@",cbUUID);
    
    for (CBService *service in peripheral.services) {
        NSLog(@"service:%@",service.UUID);
        //如果我们知道要查询的特性的CBUUID，可以在参数一中传入CBUUID数组。
        [peripheral discoverCharacteristics:nil forService:service];
    }
}
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error
{
    if (error) {
        NSLog(@"出错");
        return;
    }
    
    for (CBCharacteristic *character in service.characteristics) {
        // 这是一个枚举类型的属性
        CBCharacteristicProperties properties = character.properties;
        if (properties & CBCharacteristicPropertyBroadcast) {
            //如果是广播特性
        }
        
        if (properties & CBCharacteristicPropertyRead) {
            //如果具备读特性，即可以读取特性的value
            [peripheral readValueForCharacteristic:character];
        }
        
        if (properties & CBCharacteristicPropertyWriteWithoutResponse) {
            //如果具备写入值不需要响应的特性
            //这里保存这个可以写的特性，便于后面往这个特性中写数据
            self.character = character;
        }
        
        if (properties & CBCharacteristicPropertyWrite) {
            //如果具备写入值的特性，这个应该会有一些响应
            self.character = character;

        }
        
        if (properties & CBCharacteristicPropertyNotify) {
            //如果具备通知的特性，无响应
            [peripheral setNotifyValue:YES forCharacteristic:character];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(nonnull CBCharacteristic *)characteristic error:(nullable NSError *)error
{
    if (error) {
        NSLog(@"错误didUpdateNotification：%@",error);
        return;
    }
    
    CBCharacteristicProperties properties = characteristic.properties;
    if (properties & CBCharacteristicPropertyRead) {
        //如果具备读特性，即可以读取特性的value
        [peripheral readValueForCharacteristic:characteristic];
    }
}
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        NSLog(@"错误：%@",error);
        return;
    }
    
    NSData *data = characteristic.value;
    if (data.length <= 0) {
        return;
    }
    NSString *info = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"info:%@",info);
}
#pragma mark - tableview Datasource & delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        PrintViewController *VC = [PrintViewController new];
        MyPeripheral *temp = self.connectedArray[indexPath.row];
        VC.connectedPeripheral = temp;
        VC.delegate = self;
        [self.navigationController pushViewController:VC animated:YES];
    }else if(indexPath.section == 1){
        NSDictionary *dict = [self.deviceArray objectAtIndex:indexPath.row];
        MyPeripheral *myPer= dict[peripheralKey];
        myPer.connectStaus = CONNECT_STATUS_CONNECTING;
        // 连接某个蓝牙外设
        [manager connectPeripheral:myPer.peripheral options:@{CBConnectPeripheralOptionNotifyOnDisconnectionKey:@(YES)}];
        // 设置外设的代理是为了后面查询外设的服务和外设的特性，以及特性中的数据。
        [myPer.peripheral setDelegate:self];
        // 既然已经连接到某个蓝牙了，那就不需要在继续扫描外设了
        //    [manager stopScan];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [tableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return self.connectedArray.count;
            break;
        case 1:
            return self.deviceArray.count;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
          UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"connectedcell"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"connectedcell"];
            }
            MyPeripheral *temp = self.connectedArray[indexPath.row];
            cell.textLabel.text = temp.peripheral.name;
            cell.detailTextLabel.text = @"connected";
            cell.accessoryView = nil;
            if (cell.textLabel.text == nil)
                cell.textLabel.text = @"Unknow";
            
            UIButton *accessoryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [accessoryButton addTarget:self action:@selector(actionButtonDisconnect:)  forControlEvents:UIControlEventTouchUpInside];
            accessoryButton.tag = indexPath.row;
            [accessoryButton setTitle:@"Disonnect" forState:UIControlStateNormal];
            [accessoryButton setFrame:CGRectMake(0,0,100,35)];
            cell.accessoryView  = accessoryButton;
            return cell;
        }
            break;
        case 1:{
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            }
            NSDictionary *dic = self.deviceArray[indexPath.row];
            MyPeripheral *temp = dic[peripheralKey];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@ ",temp.peripheral.name,temp.peripheral.identifier];
            cell.detailTextLabel.text = @"";
            cell.accessoryView = nil;
            if (temp.connectStaus == CONNECT_STATUS_CONNECTING) {
                cell.detailTextLabel.text = @"connecting...";
                UIButton *accessoryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                [accessoryButton addTarget:self action:@selector(actionButtonCancelConnect:)  forControlEvents:UIControlEventTouchUpInside];
                accessoryButton.tag = indexPath.row;
                [accessoryButton setTitle:@"Cancel" forState:UIControlStateNormal];
                [accessoryButton setFrame:CGRectMake(0,0,100,35)];
                cell.accessoryView  = accessoryButton;
            }
            
            return cell;
        }
            break;
        default:
            return [UITableViewCell new];
            break;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"连接上的设备";
            break;
        case 1:
            return @"扫描到的设备";
        default:
            return @"";
            break;
    }
}

- (void)PrintViewController:(PrintViewController *)printViewController data:(NSData *)data{
    MyPeripheral *temp = self.connectedArray.firstObject;
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUnicodeStringEncoding];
    NSLog(@"%@",dataStr);
    NSLog(@"%ld",data.length);
    [temp.peripheral writeValue:data forCharacteristic:self.character type:CBCharacteristicWriteWithoutResponse];
}

#pragma mark - action
- (void)actionButtonDisconnect:(id)sender {
    //NSLog(@"[ConnectViewController] actionButtonDisconnect idx = %d",[sender tag]);
    NSInteger idx = [sender tag];
    MyPeripheral *temp = [self.connectedArray objectAtIndex:idx];
    [manager cancelPeripheralConnection:temp.peripheral];
    [self.connectedArray removeObject:temp];
//    NSIndexPath *path = [NSIndexPath indexPathForRow:idx inSection:0];
//    [self.thisTable deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];

}
- (void)actionButtonCancelConnect:(id)sender {
    //NSLog(@"[ConnectViewController] actionButtonCancelConnect idx = %d",[sender tag]);
    NSInteger idx = [sender tag];
    NSDictionary *dic = [self.deviceArray objectAtIndex:idx];
    MyPeripheral *tmpPeripheral =dic[peripheralKey];
    tmpPeripheral.connectStaus = CONNECT_STATUS_DEFAULT;
    [manager cancelPeripheralConnection:tmpPeripheral.peripheral];
//    NSIndexPath *path = [NSIndexPath indexPathForRow:idx inSection:1];
//
//    [self.thisTable reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
}
@end
