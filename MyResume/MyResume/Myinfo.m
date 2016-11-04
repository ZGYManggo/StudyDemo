//
//  Myinfo.m
//  MyResume
//
//  Created by jiemo on 15/11/23.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import "Myinfo.h"
#import "MenuView.h"
#import "MenuCell.h"
#import "SKSplashIcon.h"
#import "ViewController.h"
#import "HeadImage.h"
@interface Myinfo ()
@property (nonatomic,copy) NSString *plistPath;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) SKSplashView *splashView;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@end

@implementation Myinfo
-(void)viewWillAppear:(BOOL)animated{

    [self once];
}
-(NSString *)plistPath{
    if (!_plistPath) {
        
        // 获取document目录
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        _plistPath = [doc stringByAppendingPathComponent:@"headimage.archiver"];
    }
    
    return _plistPath;

}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 设置silde菜单栏
    _sideSlipView = [[JKSideSlipView alloc]initWithSender:self];
    _sideSlipView.backgroundColor = [UIColor redColor];
    
    MenuView *menu = [MenuView menuView];
    [menu didSelectRowAtIndexPath:^(id cell, NSIndexPath *indexPath) {
        [_sideSlipView hide];
  
        if(indexPath.row==0){
            UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
            UIViewController *viewcontroller2 = [secondStoryBoard instantiateInitialViewController];
            viewcontroller2.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
           [self presentViewController:viewcontroller2 animated:YES completion:nil];
        }
        else if(indexPath.row==1){
            UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"skill" bundle:nil];
            UIViewController *viewcontroller2 = [secondStoryBoard instantiateInitialViewController];
                     viewcontroller2.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:viewcontroller2 animated:YES completion:nil];
        }else if(indexPath.row==2){
            UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"certificate" bundle:nil];
            UIViewController *viewcontroller2 = [secondStoryBoard instantiateInitialViewController];
            viewcontroller2.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
           [self presentViewController:viewcontroller2 animated:YES completion:nil];
            
        }else if(indexPath.row==3){
            UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Activities" bundle:nil];
             UINavigationController *viewcontroller2 = [secondStoryBoard instantiateInitialViewController];
                     viewcontroller2.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:viewcontroller2 animated:YES completion:nil];
            
        
        }else if (indexPath.row==4){
        
            UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Interduce" bundle:nil];
            UIViewController *viewcontroller2 = [secondStoryBoard instantiateInitialViewController];
                    viewcontroller2.modalTransitionStyle=UIModalTransitionStylePartialCurl;
            [self presentViewController:viewcontroller2 animated:YES completion:nil];
        
        }
}];
    menu.items = @[@{@"title":@"天气",@"imagename":@"weather"},@{@"title":@"技能能力",@"imagename":@"ability"},@{@"title":@"奖状证书",@"imagename":@"jiang"},@{@"title":@"参加活动",@"imagename":@"activity"},@{@"title":@"个人简介",@"imagename":@"info"}];
    [_sideSlipView setContentView:menu];
    [self.view addSubview:_sideSlipView];
    [self.view  insertSubview:self.headImage belowSubview:_sideSlipView];
    
    
    self.headImage.layer.cornerRadius=50;
    self.headImage.layer.masksToBounds=YES;
    self.headImage.layer.borderWidth=2;
    self.headImage.layer.borderColor=[UIColor whiteColor].CGColor;
    HeadImage *head=[NSKeyedUnarchiver unarchiveObjectWithFile:self.plistPath];
    if (head.image) {
        self.headImage.image=[UIImage imageWithData:head.image];
    }
    else{
        self.headImage.backgroundColor=[UIColor grayColor];
    }
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ChangeHead {
//    UIImagePickerController *picker =[[UIImagePickerController alloc]init];
//    picker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    picker.delegate=self;
//    picker.allowsEditing=YES;
//    [self presentViewController:picker animated:YES completion:nil];
     UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"照相机",@"本地相册", nil];
     [action showInView:self.view];
    
}
#pragma mark- UIAction delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerController *imagePicler=[[UIImagePickerController alloc]init];
            imagePicler.delegate=self;
            imagePicler.allowsEditing=YES;
            imagePicler.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicler animated:YES completion:nil];
            
        
        }
            break;
        case 1:
        {
            UIImagePickerController *imagePicler=[[UIImagePickerController alloc]init];
            imagePicler.delegate=self;
            imagePicler.allowsEditing=YES;
            imagePicler.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicler animated:YES completion:nil];
            
            
        }
            break;
   
        default:
            break;
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)saveImage:(UIImage *)image {

    self.headImage.image=image;
    HeadImage *headimage=[[HeadImage alloc]init];
    headimage.image=UIImageJPEGRepresentation(image, 1.0);
    [NSKeyedArchiver archiveRootObject:headimage toFile:self.plistPath];

    
}

- (IBAction)Switch {
    [_sideSlipView switchMenu];
}
- (void) twitterSplash
{
    SKSplashIcon *twitterSplashIcon = [[SKSplashIcon alloc] initWithImage:[UIImage imageNamed:@"icon.png"] animationType:SKIconAnimationTypeBounce];
    UIColor *twitterColor = [UIColor colorWithRed:0.25098 green:0.6 blue:1.0 alpha:1.0];
    _splashView = [[SKSplashView alloc] initWithSplashIcon:twitterSplashIcon backgroundColor:twitterColor animationType:SKSplashAnimationTypeNone];
    _splashView.delegate = self; //Optional -> if you want to receive updates on animation beginning/end
    _splashView.animationDuration = 3; //Optional -> set animation duration. Default: 1s
    [self.view addSubview:_splashView];
    [_splashView startAnimation];
}
#pragma mark - SKsplash Delegate methods

- (void) splashView:(SKSplashView *)splashView didBeginAnimatingWithDuration:(float)duration
{
       //To start activity animation when splash animation starts
    [_indicatorView startAnimating];
}

- (void) splashViewDidEndAnimating:(SKSplashView *)splashView
{
    //To stop activity animation when splash animation ends
    [_indicatorView stopAnimating];
}



//GCD只执行一次
- (void)once
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self twitterSplash];
    });
    
    
}
@end
