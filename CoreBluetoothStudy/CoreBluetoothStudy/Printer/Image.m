//
//  Image.m
//  BLETR
//
//  Created by JQTEK on 15/3/30.
//  Copyright (c) 2015年 ISSC. All rights reserved.
//

#import "Image.h"

@implementation Image{
    
}

//把一幅图像分割成高度为8个点的小图片来打印
-(BOOL) printOut:(int)x width:(int)width height:(int)height mode:(IMAGE_MODE)mode data:(Byte*)data dataLength:(int)dataLength sleepTime:(int)sleepTime{
    if (width >  self.printInfo.escPageWidth) {
        return FALSE;
    }

    if (mode == SINGLE_WIDTH_8_HEIGHT || mode == DOUBLE_WIDTH_8_HEIGHT)
    {
    }
    else
    {
        return FALSE;
    }

    int count;
    count = (height - 1) / 8 + 1;
    if (dataLength != width * count) {
        return false;
    }
    [self setLineSpace:0];
    for (int i = 0; i < count; i++)
    {
        [self setXY:x y:0];
       
        [self.printInfo.wrap addByte:0x1B];
        [self.printInfo.wrap addByte:0x2A];
        [self.printInfo.wrap addByte:(Byte)mode];
        [self.printInfo.wrap addShort:(ushort)width];
        [self.printInfo.wrap addData:(data + i * width) length:width];
        [self feedEnter];
        
    }
    return [self setLineSpace:8];
}

//打印一行
-(BOOL) printOutOneLine:(Byte*)data dataLength:(int)dataLenght{
    [self.printInfo.wrap addByte:0x1F];
    [self.printInfo.wrap addByte:0x10];
    [self.printInfo.wrap addShort:dataLenght];
    return [self.printInfo.wrap addData:data length:dataLenght];
}

-(BOOL) drawOut:(int)x y:(int)y imageWidthDots:(int)imageWidthDots imageHeightDots:(int)imageHeightDots mode:(IMAGE_ENLARGE)mode imageData:(Byte*)imageData {
    if (![self setXY:x y:y])
        return FALSE;
    return [self _drawOut:imageWidthDots imageHeightDots:imageHeightDots mode:mode imageData:imageData];
}

-(BOOL)_drawOut:(int)imageWidthDots imageHeightDots:(int)imageHeightDots mode:(IMAGE_ENLARGE)mode imageData:(Byte*)imageData
{
    int Y_Byte = (imageHeightDots - 1) / 8 + 1; // 位图Y轴方向象素点的字节数；
    int X_Byte = (imageWidthDots - 1) / 8 + 1; // 位图X轴方向象素点的字节输，表示需要X_Byte幅8
    int size= Y_Byte * 8;
    // x BmpHeight的位图拼成目标位图；
    Byte* DotsBuf = (Byte*)calloc(size, sizeof(Byte));// 存放8 x BmpHeight位图的点阵数据；
    memset(DotsBuf, 0, size);
    
    int DotsBufIndex = 0; // 8xBmpHeight数据索引
    int DotsByteIndex = 0; // 原始位图数据索引
    for (int i = 0; i < X_Byte; i++) {
        for (int j = 0; j < 8; j++) {
            for (int k = 0; k < Y_Byte; k++) {
                DotsByteIndex = k * imageWidthDots + i * 8 + j;
                if ((i << 3) + j < imageWidthDots) // 当宽度大于位图实际宽度是，点阵数据为0，因为定义位图宽度为8的整数倍，而实际宽度可能不是整数倍
                    DotsBuf[DotsBufIndex++] = (Byte) imageData[DotsByteIndex];
                else
                    DotsBuf[DotsBufIndex++] = 0x00;
            }
        }
        DotsBufIndex = 0;
        [self userImageDownloadIntoRAM:1 yBytes:Y_Byte data:DotsBuf length:size];// 定义位图
        [self userImageDrawout:mode];// 打印定义位图
    }
    free(DotsBuf);
    return TRUE;
}

-(BOOL)_drawOutChar:(int)imageWidthDots imageHeightDots:(int)imageHeightDots
               mode:(IMAGE_ENLARGE)mode imageData:(char*)imageData
{
    int Y_Byte = (imageHeightDots - 1) / 8 + 1; // 位图Y轴方向象素点的字节素；
    int X_Byte = (imageWidthDots - 1) / 8 + 1; // 位图X轴方向象素点的字节素，表示需要X_Byte幅8
    // x BmpHeight的位图拼成目标位图；
    
    Byte* DotsBuf = (Byte*)calloc(Y_Byte * 8, sizeof(Byte));// 存放8 x BmpHeight位图的点阵数据；
    for (int i = 0; i < Y_Byte * 8; i++)
    DotsBuf[i] = 0;
    int DotsBufIndex = 0; // 8xBmpHeight数据索引
    int DotsByteIndex = 0; // 原始位图数据索引
    for (int i = 0; i < X_Byte; i++) {
        for (int j = 0; j < 8; j++) {
            for (int k = 0; k < Y_Byte; k++) {
                DotsByteIndex = k * imageWidthDots + i * 8 + j;
                if ((i << 3) + j < imageWidthDots) // 当宽度大于位图实际宽度是，点阵数据为0，因为定义位图宽度为8的整数倍，而实际宽度可能不是整数倍
                DotsBuf[DotsBufIndex++] = (Byte) imageData[DotsByteIndex];
                else
                DotsBuf[DotsBufIndex++] = 0x00;
            }
        }
        DotsBufIndex = 0;
        
        [self userImageDownloadIntoRAM:i yBytes:Y_Byte data:DotsBuf length:Y_Byte * 8];// 定义位图
        [self userImageDrawout:mode];// 打印定义位图
    }
    free(DotsBuf);
    return true;
}


-(BOOL)userImageDrawout:(IMAGE_ENLARGE)mode{
    [self.printInfo.wrap addByte:0x1D];
    [self.printInfo.wrap addByte:0x2F];
    return [self.printInfo.wrap addByte:(Byte)mode];
}

// / <summary>
// / 图像数据下载到打印机内存
// / 1)图像数据扫描方式是从左到右，从上到下
// / 2)数据总大小:X_BYTES * Y_BYTES *8
// / 3)X方向点数 X_BYTES * 8
// / 4)Y方向点数 Y_BYTES * 8
// / </SUMMARY>
-(BOOL)userImageDownloadIntoRAM:(int)xBytes yBytes:(int)yBytes data:(Byte*)data length:(int)length{
    if (xBytes <= 0)   return FALSE;
    if (yBytes <= 0 || yBytes > 127)   return FALSE;
    int all_data_size = xBytes * yBytes * 8;
    
    if (all_data_size > 1024)   return FALSE;
    if (all_data_size != length)  return FALSE;
    
    [self.printInfo.wrap addByte:0x1D];
    [self.printInfo.wrap addByte:0x2A];
    [self.printInfo.wrap addByte:(Byte) xBytes];
    [self.printInfo.wrap addByte:(Byte) yBytes];
  
    return [self.printInfo.wrap addData:data length:length];
}

// / <summary>
// / 根据数组绘制图像到打印机画板
// / 1)图像高度不能大于对打印机画板高度
// / 2)由于图像并没有立即输出，还可以继续在相应的x,y坐标绘制打印对象
// / </summary>
-(BOOL)drawOut:(int)x y:(int)y imageWidthDots:(int)ImageWidthDots
imageHeightDots:(int)imageHeightDots moda:(IMAGE_ENLARGE)mode imageData:(Byte*)imageData
{
  if(![self setXY:x y:y])
    return false;
    return [self _drawOut:ImageWidthDots imageHeightDots:imageHeightDots mode:mode imageData:imageData];
}

// / <summary>
// / 根据数组绘制图像到打印机画板
// / 1)图像高度不能大于对打印机画板高度
// / 2)由于图像并没有立即输出，还可以继续在相应的x,y坐标绘制打印对象
// / </summary>
-(BOOL)drawOutChar:(int)x y:(int)y imageWidthDots:(int)imageWidthDots
imageHeightDot:(int)imageHeightDots mode:(IMAGE_ENLARGE)mode imageData:(char*)imageData{
    if(![self setXY:x y:y])
    return false;
    return [self _drawOutChar:imageWidthDots imageHeightDots:imageHeightDots mode:mode imageData:imageData];
}

// / <summary>
// / 根据bitmap对象，使用自定义位图方式绘制图像到打印画板
// / 1)图像高度不能大于对打印机画板高度
// / 2)由于图像并没有立即输出，还可以继续在相应的x,y坐标绘制打印对象
// / </summary>
-(BOOL)drawOut:(int)x y:(int)y bitmap:(UIImage*)bitmap
{
    int width = bitmap.size.width;
    int height = bitmap.size.height;
    int canvasMaxHeight=200;
    if (width > self.printInfo.escPageWidth)// || height > this.canvasMaxHeight)
    {
        return false;
    }
    if (height > canvasMaxHeight) {
        return false;
    }
    
    ImageConvert *conver;
    conver=[[ImageConvert alloc]init];
    Byte*data=[conver CovertImageVertical:bitmap type:128 type:8];
    
//    if (data == NULL)
//    free(conver);
//    free(data);
//    return false;
//    if(![self setXY:x y:y])
//    free(conver);
//    free(data);
//    return false;
    return [self _drawOut:width imageHeightDots:height mode:IMAGE_ENLARGE_NORMAL imageData:data];

}

// / <summary>
// / 根据bitmap对象打印图片
// / 1)适用于所有厂家及所有型号的POS打印机
// / 2)图像立即输出,不能在图像上绘制文字
// / </summary>
-(Boolean)printOut:(int)x bitmap:(UIImage*)bitmap sleep_time:(int)sleep_time{
    int width = bitmap.size.width;
    int height = bitmap.size.height;
    if (width > self.printInfo.escPageWidth)
    return false;
    
    ImageConvert *conver;
    conver=[[ImageConvert alloc]init];
    Byte*data=[conver CovertImageVertical:bitmap type:128 type:8];
    if (data == NULL)
//    free(conver);
    free(data);
    return false;
    return [self _printOut:x width:width height:height mode:SINGLE_WIDTH_8_HEIGHT data:data sleep_time:sleep_time];
}

// / <summary>
// / 从上到下把一副大图片分割成n=((height-1)/8+1)个小图片,每个小图像宽width，高8个点。
// / 1)适用于所有厂家及型号的POS打印机
// / </summary>
-(Boolean)_printOut:(int)x width:(int)width height:(int)height
               mode:(IMAGE_MODE)mode data:(Byte[])data sleep_time:(int)sleep_time {
    if (width > self.printInfo.escPageWidth) {
        return false;
    }
    
    if (mode == SINGLE_WIDTH_8_HEIGHT
        || mode == DOUBLE_WIDTH_8_HEIGHT)
    {
    }
    else
    {
        
        return false;
    }
    int count; // 分割成多少副图片
    count = (height - 1) / 8 + 1;
    if (sizeof(data) != width * count) {
        return false;
    }
    [self setLineSpace:0];  // 设置行间距为0
    
    for (int i = 0; i < count; i++)
    {
        [self setXY:x y:0];

 
        [self.printInfo.wrap addByte:0x1B];
        [self.printInfo.wrap addByte:0x2A];
        [self.printInfo.wrap addByte:mode];
        [self.printInfo.wrap addShort:width];
        [self.printInfo.wrap addByte:*data];
        [self.printInfo.wrap add:@"\r\n"];
        [NSThread sleepForTimeInterval:sleep_time];
        
    }
    [self setLineSpace:8];// 恢复原始值 行间距为8
    
  [self.printInfo.wrap add:@"\r\n"];
    return true;
}

// / <summary>
// / 根据图片路径，使用自定义位图方式绘制图像到打印画板
// / 1)图像高度不能大于对打印机画板高度
// / 2)由于图像并没有立即输出，还可以继续在相应的x,y坐标绘制打印对象
// / </summary>
//-(Boolean)drawOut:(int)x y:(int)y image_path:(NSString)image_path{
//    if (new File(image_path).exists()) {
//        Bitmap bitmap = BitmapFactory.decodeFile(image_path);
//        return drawOut(x, y, bitmap);
//    } else {
//        return false;
//    }
//}


// / <summary>
// / 根据文件路径打印快速打印图片
// / 1)此为济强电子独有指令，不兼容别的品牌的打印机
// / 2)此方法是把一副大图片，分割成n多副小图片(高度为base_image_height)来打印。
// / 3)根据上位机的数据传输速度，可以调整base_image_height的大小来获得不同的图像打印速度。
// / 4)使用此方法，不可以在其余区域绘制别的东西。如果需要在图片上绘制别的打印对象请使用drawOut相关函数
// / 5)需要配合最新的打印机固件使用
// / </summary>

//-(Boolean)printOutFast:(int)x image_path:(NSString)image_path sleep_time:(int)sleep_time
//     base_image_height:(int)base_image_height
//{
//    if (new File(image_path).exists())
//    {
//        Bitmap bitmap = BitmapFactory.decodeFile(image_path);
//        return printOutFast(x, bitmap, sleep_time, base_image_height);
//    } else
//    {
//
//        return false;
//    }
//}






@end
