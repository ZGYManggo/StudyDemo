//
//  CZCar.m
//  weatherWithUrlSeesion
//
//  Created by jiemo on 15/11/26.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import "CZCar.h"

@implementation CZCar
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}


+ (instancetype)carWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}


@end
