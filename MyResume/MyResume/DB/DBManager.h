//
//  DBManager.h
//  MyResume
//
//  Created by jiemo on 15/12/1.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject<NSCoding>
@property (copy, nonatomic)  NSString *name;
@property (copy, nonatomic)  NSString *sex;
@property (copy, nonatomic)  NSString *brithday;
@property (copy, nonatomic)  NSString *school;
@property (copy, nonatomic)  NSString *zhuanye;
@property (copy, nonatomic)  NSString *afterschooltime;
@property (copy, nonatomic)  NSString *jiguan;
@property (copy, nonatomic)  NSString *location;
@property (copy, nonatomic)  NSString *phonenumber;

+(instancetype)shareInstance;
@end
