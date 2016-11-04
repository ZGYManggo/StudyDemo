//
//  CaculateManger.m
//  链式编程加法计算器
//
//  Created by jiemo on 16/10/16.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "CaculateManger.h"

@implementation CaculateManger
- (CaculateManger* (^)(int))add{
    return ^(int value){
        self.result +=value;
        return self;
    };
}
@end
