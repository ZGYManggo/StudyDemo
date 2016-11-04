//
//  NSObject+Model.m
//  RunTimeModel
//
//  Created by jiemo on 16/10/8.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/message.h>
@implementation NSObject (Model)

+ (instancetype)modelWithDict:(NSDictionary *)dict{

    /*
     ivar:成员属性
     class_copyIvarList:成员属性列表复制一份
     Ivar *:指向Ivar的指针 或者指向一个数组的指针
     */
    id objc = [[self alloc]init];
    unsigned int count = 0;
    Ivar *ivar = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar var = ivar[i];
        NSString *propertyName = [NSString stringWithUTF8String:ivar_getName(var)];
        NSString *propertyType = [NSString stringWithUTF8String:ivar_getTypeEncoding(var)];
        NSString *key = [propertyName substringFromIndex:1];
        id value = dict[key];
        if ([value isKindOfClass:[NSDictionary class]] && ![propertyType containsString:@"NSDictionary"]){
            NSRange range = [propertyType rangeOfString:@"\""];
            propertyType = [propertyType substringFromIndex:range.location + range.length];
            range = [propertyType rangeOfString:@"\""];
            propertyType = [propertyType substringToIndex:range.location];
            Class modelClass = NSClassFromString(propertyType);
            if (modelClass) {
                value = [modelClass modelWithDict:value];
            }
        }
        if (value) {
            [objc setValue:dict[key] forKey:key];

        }
        
    }
    return objc;
    
}

@end
