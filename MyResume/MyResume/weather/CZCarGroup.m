//
//  CZCarGroup.m
//  weatherWithUrlSeesion
//
//  Created by jiemo on 15/11/26.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import "CZCarGroup.h"
#import "CZCar.h"
@implementation CZCarGroup
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}


+ (instancetype)carGroupWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

+ (NSArray *)carGroupsList
{
    //加载plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
    
    //字典转模型
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (NSDictionary *dic in dicArray) {
        CZCarGroup *carGroup = [CZCarGroup carGroupWithDic:dic];
        
        //字典转模型
        NSMutableArray *tmpCarArray = [NSMutableArray array];
        for (NSDictionary *dicTmp in carGroup.city) {
            CZCar *car = [CZCar carWithDic:dicTmp];
            [tmpCarArray addObject:car];
        }

        carGroup.city = tmpCarArray;
        
        [tmpArray addObject:carGroup];
    }
    return tmpArray;
}
@end
