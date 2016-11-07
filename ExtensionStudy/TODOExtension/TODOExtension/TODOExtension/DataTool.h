//
//  DataTool.h
//  TODOExtension
//
//  Created by jiemo on 16/11/6.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTool : NSObject
+(instancetype)shareDataTool;
- (void)addData:(NSString *)str;
- (NSArray<NSString *> *)getData;
- (void)updataData:(NSArray *)data;
@end
