//
//  ImageConvert.m
//  BLETR
//
//  Created by JQTEK on 15/3/25.
//  Copyright (c) 2015年 ISSC. All rights reserved.
//

#import "ImageConvert.h"

@implementation ImageConvert

@synthesize m_width;
@synthesize m_height;
@synthesize m_datasize;

-(Boolean) PixelIsBlack:(int)color type:(int)gray_threshold{
    int red = ((color & 0x00FF0000) >> 16);
    int green = ((color & 0x0000FF00) >> 8);
    int blue = color & 0x000000FF;
    int grey = (int) ((float) red * 0.299 + (float) green * 0.587 + (float) blue * 0.114);
    return (grey < gray_threshold);
}

- (UIColor*) getRGB:(int)x type:(int)y
{
     NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * self.m_width;
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    NSUInteger byteIndex = (bytesPerRow * y) + x * bytesPerPixel;
    CGFloat red   = (m_rawData[byteIndex]     * 1.0) / 255.0;
    CGFloat green = (m_rawData[byteIndex + 1] * 1.0) / 255.0;
    CGFloat blue  = (m_rawData[byteIndex + 2] * 1.0) / 255.0;
    CGFloat alpha = (m_rawData[byteIndex + 3] * 1.0) / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];

    
}

-(Byte*)CovertImageVertical:(UIImage*)bitmap type:(int)gray_threshold type:(int)column_dots
{
    self.m_width = bitmap.size.width;
    self.m_height = bitmap.size.height;
    if (m_width>384) {
        NSLog(@"image width>384");
        return nil;
        
    }
    // First get the image into your data buffer
    CGImageRef imageRef = [bitmap CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    m_rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(m_rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    

    int count = (self.m_height - 1) / column_dots + 1;//分成多少个小图片
    int column_bytes = column_dots/8;
    self.m_datasize=width * column_bytes * count;
    m_data = (Byte*) calloc(self.m_datasize,sizeof(Byte));
 
    
    int index = 0;
    //根据位图各点的灰度值，确定打印位图相应的点的黑白色
    int sx = 0, sy = 0;                                                                          //位图的x，y坐标值；
    for (int i = 0; i < count; i++)                                                     //8行像素行构成以小行，一幅位图需要LengthColumn个小行；
    {
        for (int j = 0; j < self.m_width; j++)                                     //一小行的位图数据有BmpWidth列，需要BmpWidth个字节存放；
        {
            sx = j;                                                                             //位图当前像素点的x坐标为列数x；
            for (int k = 0; k < 8; k++)                                                        //k，小行中8行像素行的当前行；
            {
                sy = (i << 3) + k;                                                              //位图当前像素点的y坐标为(小行数×8)+k;
                if (sy >= self.m_height)                                            //如果位图当前像素点的y坐标大于实际位图高度(位图实际高度可能不为8的整数倍)，不对该点颜色进行判断；
                {
                    continue;
                }
                else
                {
                    int color =(int)[self getRGB:sx type:sy];
                    if([self PixelIsBlack:color type:gray_threshold])
                   // if ([self PixelIsBlack:bitmap.getPixel(sx, sy) type:gray_threshold])                    //判断当前点是否为黑色；
                    {
                        m_data[index] |= (Byte)(0x01 << (7 - k));      //如果为黑色，当前点所对应字节的对应为赋值为1；
                    }
                }
            }
            index++;                                                      //一小行的一列像素点判断完毕后，位图数据实际长度加1；
        }
    }
    free(m_rawData);

    return m_data;
}

-(void)dealloc {
    if (m_data != nil)
    {
        free(m_data);
        m_data = nil;
    }

   
//    [super dealloc];
}

/// <summary>
/// 水平方式转换图像为数组
/// </summary>
/// <param name="bitmap">图像@param
/// <param name="gray_threshold">阈值@param
/// <returns>null表示失败，否则返回数据数组</returns>
-(Byte *)CovertImageHorizontal:(UIImage*)bitmap gray_threshold:(int)gray_threshold
{
    self.m_width = bitmap.size.width;
    self.m_height = bitmap.size.height;
    int BytesPerLine = (m_width - 1) / 8 + 1;
    
    self.m_datasize=BytesPerLine * m_height;
    m_data = (Byte*) calloc(self.m_datasize,sizeof(Byte));

    
    int index = 0;
    
    //根据位图各点的灰度值，确定打印位图相应的点的黑白色
    int x = 0, y = 0;                                                                          //位图的x，y坐标值；
    for (int i = 0; i < m_height; i++)                                        //每次判断一像素行，需要判断BmpHeight次
    {
        for (int j = 0; j < BytesPerLine; j++)                                                    //每行需要LengthRow字节存放数据，
        {
            for (int k = 0; k < 8; k++)                                                        //每个字节存放8个点，即1点1位；
            {
                x = (j << 3) + k;                                                              //x坐标为已计算字节×8+当前字节的位k；
                y = i;                                                                         //当前行；
                if (x >= m_width)                                             //如果位图当前像素点的y坐标大于实际位图宽度(位图实际宽度可能不为8的整数倍)，不对该点颜色进行判断；
                {
                    continue;
                }
                else
                {
                    int color =(int)[self getRGB:x type:y];
                    if([self PixelIsBlack:color type:gray_threshold])
                    {
                        m_data[index] |= (Byte)(0x01 << k);
                    }
                }
            }
            index++;                                                       //一行像素行8点判断完毕后，位图数据实际长度加1；
        }
        x = 0;
    }
    
    return m_data;
}




@end
