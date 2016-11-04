//
//  CZCar.h
//  weatherWithUrlSeesion
//
//  Created by jiemo on 15/11/26.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZCar : NSObject
@property (nonatomic,copy) NSString *citynm;


- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)carWithDic:(NSDictionary *)dic;


@end
