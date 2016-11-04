//
//  NSObject+Caculate.h
//  链式编程加法计算器
//
//  Created by jiemo on 16/10/16.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CaculateManger.h"
@interface NSObject (Caculate)
+ (int)makeCaculate:(void(^)(CaculateManger *))block;
@end
