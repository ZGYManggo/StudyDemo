//
//  DataTool.m
//  TODOExtension
//
//  Created by jiemo on 16/11/6.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "DataTool.h"

static NSString * const dataKey = @"dataKey";

static DataTool *shareTool;

@interface DataTool()

@property (nonatomic,strong) NSUserDefaults *userDefatults;

@end

@implementation DataTool

-(NSUserDefaults *)userDefatults{
    if (!_userDefatults) {
        _userDefatults = [[NSUserDefaults alloc]initWithSuiteName:@"group.ZGYStudy"];
    }
    return _userDefatults;
}

+(instancetype)shareDataTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareTool = [[self alloc]initPrivate];
    });
    return shareTool;
}
- (instancetype)initPrivate {
    self  = [super init];
    return self;
}
- (instancetype)init {
    @throw [NSException exceptionWithName:@"这个是个单例"
                                   reason:@"应该这样调用 [shareDataTool]"
                                 userInfo:nil];
    return nil;
}


- (void)addData:(NSString *)str{
    NSArray<NSString *> *dataArr = [self.userDefatults objectForKey:dataKey];
    NSMutableArray<NSString *> *temp = [NSMutableArray arrayWithArray:dataArr];
    [temp addObject:str];
    [self.userDefatults setObject:temp forKey:dataKey];
    [self.userDefatults synchronize];
}

- (NSArray<NSString *> *)getData{
    return  [self.userDefatults objectForKey:dataKey];
}

- (void)updataData:(NSArray *)data{
    [self.userDefatults setObject:data forKey:dataKey];
    [self.userDefatults synchronize];
}

@end
