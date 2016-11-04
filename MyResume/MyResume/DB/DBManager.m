//
//  DBManager.m
//  MyResume
//
//  Created by jiemo on 15/12/1.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager
static DBManager *_instance=nil;
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.sex  forKey:@"sex"];
    [aCoder encodeObject:self.brithday forKey:@"brithday"];
    [aCoder encodeObject:self.school forKey:@"school"];
    [aCoder encodeObject:self.zhuanye forKey:@"zhuanye"];
    [aCoder encodeObject:self.afterschooltime forKey:@"afterschooltime"];
    [aCoder encodeObject:self.jiguan forKey:@"jiguan"];
    [aCoder encodeObject:self.location forKey:@"location"];
    [aCoder encodeObject:self.phonenumber forKey:@"phonenumber"];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.brithday = [aDecoder decodeObjectForKey:@"brithday"];
        self.school = [aDecoder decodeObjectForKey:@"school"];
        self.zhuanye = [aDecoder decodeObjectForKey:@"zhuanye"];
        self.afterschooltime = [aDecoder decodeObjectForKey:@"afterschooltime"];
        self.jiguan = [aDecoder decodeObjectForKey:@"jiguan"];
        self.location = [aDecoder decodeObjectForKey:@"location"];
        self.phonenumber = [aDecoder decodeObjectForKey:@"phonenumber"];
    }
    
    return self;

}
+(instancetype)shareInstance{
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
