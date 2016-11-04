//
//  SearchController.m
//  weatherWithUrlSeesion
//
//  Created by jiemo on 15/11/25.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import "SearchController.h"
#import "CZCar.h"
#import "CZCarGroup.h"
#import <CoreLocation/CoreLocation.h>
@interface SearchController ()<CLLocationManagerDelegate>
- (IBAction)cannel;
@property (weak, nonatomic) IBOutlet UITextField *citynm;
@property (nonatomic , strong)CLLocationManager *locationManager;
- (IBAction)confirm;

@property (nonatomic, strong) NSArray *carGroups;
@end

@implementation SearchController

-(CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager=[[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 10;
         [_locationManager requestAlwaysAuthorization];
        [_locationManager requestWhenInUseAuthorization];
    }

    return _locationManager;
}

- (NSArray *)carGroups
{
    if (_carGroups == nil) {
        _carGroups = [CZCarGroup carGroupsList];
        
    }
    return _carGroups;
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
            
        case kCLAuthorizationStatusNotDetermined:
            
            if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [_locationManager requestWhenInUseAuthorization];
            }
            break;
            
        default:
            
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
  

    // Do any additional setup after loading the view.
   
}





- (IBAction)cannel {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)confirm {
    if(self.citynm.text!=nil&&![self.citynm.text isEqualToString:@""]){
    [AppStatus shareInstance].contextStr=self.citynm.text;
    }
    [self cannel];
}


#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //共多少组
    return self.carGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //
    CZCarGroup *carGroup = self.carGroups[section];
    return carGroup.city.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1 创建可重用cell对象
    static NSString *reuseId = @"car";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    
    //2 给cell内部的子控件赋值
    //
    CZCarGroup *carGroup = self.carGroups[indexPath.section];
    
    cell.textLabel.text = [carGroup.city[indexPath.row] citynm];
    
    
    
    //3 返回cell
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.carGroups[section] title];
}
//返回组的索引标题
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //kvc
    return [self.carGroups valueForKeyPath:@"title"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CZCarGroup *carGroup = self.carGroups[indexPath.section];

   // NSLog(@"%@", [carGroup.city[indexPath.row] citynm]);
 
    [AppStatus shareInstance].contextStr=[carGroup.city[indexPath.row] citynm];
    [self cannel];
    
    
}
- (IBAction)GPS {
  
    [self.locationManager startUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
     NSLog(@"!!!!");
    // 1.获取用户位置的对象
    CLLocation *location = [locations firstObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    // NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://api.map.baidu.com/geocoder/v2/?ak=acWoNhUe93lLLsFU8XzzGNgZ&location=%f,%f&output=json",coordinate.latitude,coordinate.longitude]];
    NSLog(@"%@",url);
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionTask *task=[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
       
        NSString *locality=dic[@"result"][@"addressComponent"][@"city"];
        NSRange range = [locality rangeOfString:@"市"];
                if (range.length > 0) {
                        // 将最后一个字符【市】去掉
                         locality = [locality substringToIndex:locality.length - 1]; // 城市
                    }
        NSLog(@"%@",locality);
        self.citynm.text=locality;
        [self confirm];
        
        
    }];
    [task resume];
    // 2.停止定位
    [self.locationManager stopUpdatingLocation];
    
}


@end
