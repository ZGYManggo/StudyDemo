//
//  CZCarGroup.h
//  weatherWithUrlSeesion
//
//  Created by jiemo on 15/11/26.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZCarGroup : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) NSArray *city;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)carGroupWithDic:(NSDictionary *)dic;

+ (NSArray *)carGroupsList;
@end
