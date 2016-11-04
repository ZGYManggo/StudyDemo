//
//  APPStatus.h
//  weatherWithUrlSeesion
//
//  Created by jiemo on 15/11/26.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppStatus : NSObject{
 
         NSString *_contextStr;
}

@property(nonatomic,retain)NSString *contextStr;

+(AppStatus *)shareInstance;

 @end
