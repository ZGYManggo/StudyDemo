//
//  APPStatus.m
//  weatherWithUrlSeesion
//
//  Created by jiemo on 15/11/26.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import "APPStatus.h"

@implementation AppStatus

 @synthesize contextStr = _contextStr;

static AppStatus *_instance=nil;
 +(AppStatus *)shareInstance
 {
         if (_instance == nil)
             {
                     _instance = [[super alloc]init];
                 }
         return _instance;
     }

 -(id)init
 {
         if (self = [super init])
             {
            
                 }
         return self;
     }


@end
