//
//  PrintViewController.m
//  CoreBluetoothStudy
//
//  Created by jiemo on 17/1/4.
//  Copyright © 2017年 张高远. All rights reserved.
//

#import "PrintViewController.h"
#import "Printer.h"
#import "UIImage+Bitmap.h"
@interface PrintViewController ()
@property (nonatomic,strong)  Printer *printer;
@end

@implementation PrintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.printer=[[Printer alloc]init];

    // Do any additional setup after loading the view.
    UIButton *printBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [printBtn setTitle:@"print" forState:UIControlStateNormal];
    printBtn.frame = CGRectMake(100, 100, 50, 50);
    [self.view addSubview:printBtn];
    self.view.backgroundColor = [UIColor whiteColor];
    [printBtn addTarget:self action:@selector(tappedPrintBtn) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = [UIColor blackColor];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"PrintLogo.png"]];
    imgView.frame = CGRectMake(100,250, 120, 135);
    [self.view insertSubview:imgView atIndex:self.view.subviews.count];
}

- (void)tappedPrintBtn{
    if(self.printer.sendFinish == TRUE)
    {
        return;
    }
    self.printer.sendFlag = TRUE;
    [self wrapPrintData];
    if (self.printer.printerInfo.wrap.dataLength) {
        self.printer.sendFinish = TRUE;
    }
    [self sendPrintData];
}

- (void)wrapPrintData{
    
    int y,y1, y2, y3, y4, x, x1, x2, x3 = 0;
    int fontSmall = 18;
    int textStartX = 10;
    int stepY = 48;
    int endX= 575;
    int midX = endX/2;
    
    [self.printer.printerInfo.wrap reset];//缓冲区复位
    [self.printer.esc restorePrinter];//
    [self.printer.jpl.page start:0 originY:0 pageWidth:576 pageHeight:100 rotate:x0];
    
    [self.printer.jpl.grahic line:0 startPointY:y endPointX:576 endPointY:y width:3];
    x1+=120;
    if (![self.printer.esc.text drawOut:x1 y:y height:x24 bold:NO text:@"重庆城市物流"]) {
        NSLog(@"false ");
        self.printer.sendFlag = FALSE;
    }
    
    y+=32;
    
    [self.printer.esc.text drawOut:x1 y:y height:x24 bold:NO text:@".........."];
    [self.printer.jpl.grahic line:x1 startPointY:0 endPointX:x1 endPointY:136 width:3];
//    [self.printer.jpl.grahic line:x1 startPointY:0 endPointX:x1 endPointY:136 width:3];
    y1 = 88;
     [self.printer.jpl.grahic line:x1 startPointY:y1 endPointX:endX endPointY:y1 width:3];
    
    y2 = 136;
    [self.printer.jpl.grahic line:0 startPointY:y2 endPointX:endX endPointY:y2 width:3];

    x3 = 120+50;
    [self.printer.esc.text drawOut:x3 y:y1 + 10 height:x24 bold:NO text:@"老顶坡"];
    
//    int x4 = 360;
//    [self.printer.jpl.text drawOut:x4 y:y1 + 10 text:@"发往" fontHeight:fontSmall bold:FALSE reverse:FALSE underLien:FALSE deleteLine:FALSE enlargeX:x1 enlargeY:x1 rotateAngle:ROTATE_0];
//    
//    int x5 = 360+60;
//    [self.printer.jpl.text drawOut:x4 y:y1 + 10 text:@"收货地" fontHeight:fontSmall bold:FALSE reverse:FALSE underLien:FALSE deleteLine:FALSE enlargeX:x1 enlargeY:x1 rotateAngle:ROTATE_0];
//
//    [self.printer.jpl.grahic line:0 startPointY:y2 endPointX:endX endPointY:y2 width:3];
//    
//    y3 = 184;
//    [self.printer.jpl.grahic line:0 startPointY:y3 endPointX:endX endPointY:y3 width:3];
//    
//    int x6 = 180;
//    [self.printer.jpl.text drawOut:textStartX y:y2 + 10 text:@"收件人" fontHeight:fontSmall bold:FALSE reverse:FALSE underLien:FALSE deleteLine:FALSE enlargeX:x1 enlargeY:x1 rotateAngle:ROTATE_0];
//    
//    [self.printer.jpl.text drawOut:x6 y:y2 + 10 text:@"张高远" fontHeight:fontSmall bold:FALSE reverse:FALSE underLien:FALSE deleteLine:FALSE enlargeX:x1 enlargeY:x1 rotateAngle:ROTATE_0];
//    
//    int x7 = 384;
//    [self.printer.jpl.grahic line:x7 startPointY:y2 endPointX:x7 endPointY:y3 width:3];
//
//    [self.printer.jpl.text drawOut:x7 +10 y:y2 + 10 text:@"电话" fontHeight:fontSmall bold:FALSE reverse:FALSE underLien:FALSE deleteLine:FALSE enlargeX:x1 enlargeY:x1 rotateAngle:ROTATE_0];
//    
//    int x8 = 450;
//    [self.printer.jpl.text drawOut:x8  y:y2 + 10 text:@"188888888888" fontHeight:fontSmall bold:FALSE reverse:FALSE underLien:FALSE deleteLine:FALSE enlargeX:x1 enlargeY:x1 rotateAngle:ROTATE_0];
//
//    y4 = 232;
//    [self.printer.jpl.grahic line:0 startPointY:y4 endPointX:endX endPointY:y4 width:3];

    
    [self.printer.jpl.page end];
    [self.printer.jpl.page print];
    [self.printer.jpl feedMarkOrGap:0];
}

//- (void)wrapPrintData {
//    
//    
//    [self.printer.printerInfo.wrap reset];//缓冲区复位
//    [self.printer.esc restorePrinter];//
//    
    // 卫生行政执法文书
    //    [self.printer.esc.image drawOut:32 y:0 imageWidthDots:106 imageHeightDots:106 mode:IMAGE_ENLARGE_NORMAL imageData:logo_data];
//        [self.printer.esc.text drawOut:150 y:29 height:x24 bold:TRUE enlarge:TEXT_ENLARGE_HEIGHT_WIDTH_DOUBLE text:@"卫生行政执法文书"];
//    for (int i = 0; i < 4; i++) {//测试发现是线的厚度
//        [self.printer.esc.grahic linedrawOut:0 endPoint:575];
//    }

//    for (int i = 0; i < 4; i++) {//测试发现是线的厚度
//        [self.printer.jpl.grahic line:0 startPointY:0 endPointX:0 endPointY:50 width:5];
//    }
//    [self.printer.esc feedDots:4];
//
//    [self.printer.esc.text drawOut:CENTER height:x24 bold:TRUE enlarge:TEXT_ENLARGE_NORMAL text:@"现场检测笔录"];
//    //    [self.printer.esc.barcode code128_auto_drawOut:CENTER unit:BARx3 height:56 pos:BOTTOM size:BAR_ASCII_8x16 str:@"A02161645760"];
//    [self.printer.esc.barcode code128_auto_printOut:LEFT unit:BARx2 height:70 pos:BOTTOM size:BAR_ASCII_8x16 str:@"800SH2015051000054-1"];
//    [self.printer.esc.text drawOut:LEFT height:x24 bold:FALSE enlarge:TEXT_ENLARGE_NORMAL text:@""];
//    [self.printer.esc.text printOut:@"被检查人：上海济强电子科技有限公司"];
//    [self.printer.esc.text printOut:@"联系电话：13371967607  邮政编码：201206"];
//    [self.printer.esc.text printOut:@"法定代表人(或责任人)：张三    职务：总经理"];
//    [self.printer.esc.text printOut:@"检查机关：浦东1队"];
//    [self.printer.esc.text printOut:@"检查时间：yyyy年MM月dd日HH时"];
//    [self.printer.esc.text printOut:@"检查地点：浦东金藏路258号2号楼2层\n"];
//    [self.printer.esc.text printOut:@"检查人员示证检查，检查记录："];
//    [self.printer.esc.text printOut:@"    卫生监督员李四 和王二在赵大的陪同下,对上海济强电子科技有限公司进行了检查，经检查发现："];
//    [self.printer.esc.text printOut:@"1.门外有垃圾。\n2.门口有小广告。\n3.厕所未及时清洁。\r\n"];
//    [self.printer.esc.barcode barcode2D_QRCode:1 ecc:3 text:@"1234567a" length:8];
//    [self.printer.esc feedDots:200];
//    [self.printer.esc.text printOut:@"被检查人阅后签名：\n"];
//    [self.printer.esc.text drawOut:0 y:16 text:@"日期    年  月  日"];
//    [self.printer.esc.text drawOut:280 y:32 text:@"卫生行政机关盖章"];
//    [self.printer.esc.text drawOut:280 y:0 text:@"2015年4月14日"];
//    [self.printer.esc feedEnter];
//    [self.printer.esc.text printOut:@"卫生监督员签名：\n"];
//    [self.printer.esc.text printOut:@"日期    年  月  日"];
//    for (int i = 0; i < 4; i++) {
//        [self.printer.esc.grahic linedrawOut:0 endPoint:575];
//    }
//    
//    [self.printer.esc feedDots:4];
//    [self.printer.esc.text printOut:RIGHT height:x16 bold:FALSE enlarge:TEXT_ENLARGE_NORMAL text:@"中华人民共和国卫生部制定"];
//    [self.printer.esc feedLines:3];
    
    
//    [self.printer.esc feedEnter];
    
//}

//发送打印数据
-(void) sendPrintData {
    if (!self.printer.sendFlag) return;
//    if (![self.connectedPeripheral.transmit canSendReliableBurstTransmit]) {
//        [NSTimer scheduledTimerWithTimeInterval:0.00001 target:self selector:@selector(sendPrintData) userInfo:nil repeats:NO];
//        
//        return;
//    }
    int r = self.printer.printerInfo.wrap.dataLength;
    if (r==0) {
        self.printer.sendFlag = FALSE;
        self.printer.sendFinish = FALSE;
        return;
    }
    
    //    int sendLength = printer.port.transmit.transmitSize;
    int sendLength = 64;
    if (r < sendLength) {
        sendLength = r;
    }
    NSData *data = [self.printer.printerInfo.wrap getData:sendLength];
    
    [self sendTransparentDataA:data];
}
- (void)sendTransparentDataA:(NSData *)data {
    if ([self.delegate respondsToSelector:@selector(PrintViewController:data:)]) {
        [self.delegate PrintViewController:self data:data];
    }
        [NSTimer scheduledTimerWithTimeInterval:0.00001 target:self selector:@selector(sendPrintData) userInfo:nil repeats:NO];
}
@end
