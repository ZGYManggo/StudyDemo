//
//  CaculateManger.h
//  链式编程加法计算器
//
//  Created by jiemo on 16/10/16.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaculateManger : NSObject
@property (nonatomic,assign) int result;
- (CaculateManger* (^)(int))add;
@end
