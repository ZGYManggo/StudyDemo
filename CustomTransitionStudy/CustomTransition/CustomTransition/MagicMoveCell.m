//
//  MagicMoveCell.m
//  CustomTransition
//
//  Created by jiemo on 16/11/30.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "MagicMoveCell.h"

@implementation MagicMoveCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.thisImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg04.jpg"]];
        self.thisImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.thisImageView.frame = CGRectMake(0, 50, 50, 50);
        UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,50)];
        text.text = @"12319yajdkjbdflkasbdfkabskfbaskjhfbjhakbfjbhakbfkjahsbdf";
        text.numberOfLines = 0;
        [self.contentView addSubview:self.thisImageView];
        [self.contentView addSubview:text];
    }
    return self;
}

@end
