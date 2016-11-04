//
//  ViewController.m
//  GetCustomImageMostColor
//
//  Created by jiemo on 16/11/2.
//  Copyright © 2016年 张高远. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UIColor *customBackgroundColor;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.customBackgroundColor = [self mostColor:[UIImage imageNamed:@"bgImage"]];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 50, 50)];
    view.backgroundColor = self.customBackgroundColor;
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(150, 150, 50, 50)];
    view2.backgroundColor = [self get];
    [self.view addSubview:view];
    [self.view addSubview:view2];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (UIColor *)mostColor:(UIImage *)image {
    NSLog(@"begin");

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize = CGSizeMake(20, 20);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    //第二步 取每个点的像素值
    unsigned char *data = CGBitmapContextGetData (context);
    
    if (data == NULL) return nil;
    
    NSCountedSet *cls = [NSCountedSet setWithCapacity:thumbSize.width * thumbSize.height];

    for (int x = 0; x < thumbSize.width; ++x) {
        for (int y = 0; y < thumbSize.height; ++y) {
            int offset = 4 * (x * y);
            
            int red = data[offset];
            int green = data[offset + 1];
            int blue = data[offset + 2];
            int alpha =  data[offset + 3];
            
            NSArray *clr=@[@(red), @(green), @(blue), @(alpha)];
            [cls addObject:clr];
            NSLog(@"progress x=%i y=%i",x,y);

        }
    }
    CGContextRelease(context);
    
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    
    NSArray *MaxColor = nil;
    NSUInteger MaxCount = 0;
    
    while ((curColor = [enumerator nextObject]) != nil)
    {
        NSUInteger tmpCount = [cls countForObject:curColor];
        
        if (tmpCount < MaxCount) continue;
        
        MaxCount = tmpCount;
        MaxColor = curColor;
    }
    NSLog(@"end");
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}

- (UIColor *)get{
    CGFloat red = 0;
    CGFloat green = 0;
    CGFloat blue = 0;
    if ([[self customBackgroundColor] getRed:&red green:&green blue:&blue alpha:nil]) {
        if ((red + green + blue) * 255 > 600) {
            return [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        }else {
            return [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
        }
    }else {
        return [UIColor new];
    }
}

@end
