//
//  NSObject+Caculate.m
//  链式编程加法计算器
//
//  Created by jiemo on 16/10/16.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "NSObject+Caculate.h"

@implementation NSObject (Caculate)

+ (int)makeCaculate:(void(^)(CaculateManger *))block{
    
    CaculateManger *manger = [[CaculateManger alloc]init];
    block(manger);
    return manger.result;

}


@end
