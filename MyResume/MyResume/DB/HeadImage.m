//
//  HeadImage.m
//  MyResume
//
//  Created by jiemo on 15/12/2.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import "HeadImage.h"

@implementation HeadImage
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.image forKey:@"image"];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.image = [aDecoder decodeObjectForKey:@"image"];
    }
    
    return self;
    
}
@end
