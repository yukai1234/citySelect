
//
//  centerViewController.m
//  TextView
//
//  Created by 俞凯 on 16/3/18.
//  Copyright © 2016年 俞凯. All rights reserved.
//
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#import "centerViewController.h"
#import "SDPhotoBrowser.h"
@interface centerViewController ()<UIScrollViewDelegate>
{
    UIView *container_view;
    
    UIScrollView *container_scrollView;
    
    UIView *snapView;
    
    CGRect originalImageRect;
    
    CGRect picRect;
    
    UIImageView *snapImg;
}
@property(nonatomic,strong)UIImageView *imgV;
@end

@implementation centerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"图片";
    [self creatBtnWithFrame:CGRectMake(100, 80, 50, 50) andTitle:@"清理缓存" andtitltColor:[UIColor purpleColor] andBtnType:UIButtonTypeCustom andTarget:self andAction:@selector(btnClick:)];
    
    
    
   // [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
   // [self prefersStatusBarHidden];
    [self configUI];
}
-(void)btnClick:(UIButton *)sender
{
   // NSString *path=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    //在document目录下创建文件
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    NSFileManager *manager=[NSFileManager defaultManager];
    
    NSString *directoy=[path stringByAppendingPathComponent:@"testcoo"];
    
    [manager createDirectoryAtPath:directoy withIntermediateDirectories:YES attributes:nil error:nil];
    NSLog(@"====%@",path);
//    float memeroySize;
//    
//    if([manager fileExistsAtPath:path])
//    {
//        NSArray *childFiles=[manager subpathsAtPath:path];
//        
//        for(NSString *fileNames in childFiles)
//            {
//                NSString *fullPath=[path stringByAppendingString:fileNames];
//                memeroySize +=[self fileSizeAtPath:fullPath];
//            }
//       UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"清理缓存" message:[NSString stringWithFormat:@"缓存大小为%.2fM,确定要清理缓存吗?", memeroySize] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alt show];
//        
//    }
}
-(float)fileSizeAtPath:(NSString *)path
{
    NSFileManager *manager=[NSFileManager defaultManager];
    
    if([manager fileExistsAtPath:path])
    {
        long  long size=[manager attributesOfItemAtPath:path error:nil].fileSize;
        
        return size/1024/1024;
    }
    return 0;
}
-(void)configUI
{
    
//    UIView *myView=[[UIView alloc]initWithFrame:self.view.bounds];
//    
//    myView.backgroundColor=[UIColor yellowColor];
//    _myView=myView;
//    [self.view addSubview:myView];
    
    
    
    
    //间距
    CGFloat Wjianju=20.0;
    
    
    //图片长宽
    CGFloat picW=(self.view.frame.size.width-2*Wjianju)/3;
    
    CGFloat picH=picW;
    
    CGFloat y=self.view.frame.size.height/2-picH;
    
    for(int i=0;i<3;i++)
    {
        for(int j=0;j<3;j++)
        {
            UIImageView *imgV=[[UIImageView alloc]initWithFrame:CGRectMake((Wjianju+picW)*i, y+(picH+Wjianju)*j, picW, picH)];
            picRect=imgV.frame;
            
            imgV.tag=100+i+j*3;
            imgV.image=[UIImage imageNamed:[NSString stringWithFormat:@"00%d",i+j*3+1]];
            
            _imgV=imgV;
            [self.view addSubview:imgV];
            //利用循环给每张图片添加手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapp:)];
            _imgV.userInteractionEnabled=YES;
            [_imgV addGestureRecognizer:tap];
            
            
            UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
            
            [_imgV addGestureRecognizer:longPress];
           
        }
    }
   
}
-(void)creatBtnWithFrame:(CGRect)frame andTitle:(NSString *)title andtitltColor:(UIColor *)color andBtnType:(UIButtonType)type andTarget:(id)target andAction:(SEL)action
{
    
    UIButton *clearFileBtn=[UIButton buttonWithType:type];
    
    clearFileBtn.frame=frame;
    [clearFileBtn setTitle:title forState:UIControlStateNormal];
    
    [clearFileBtn setTitleColor:color forState:UIControlStateNormal];
    
    [clearFileBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearFileBtn];
    
}
//长按保存图片到相册和本地
-(void)longPress:(UILongPressGestureRecognizer *)sender
{
    
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(error)
    {
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:nil message:@"保存失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
    }
    else{
        NSLog(@"ok");
    }
}
-(void)tapp:(UITapGestureRecognizer *)tap
{
    //获取点击的图片 show
    NSLog(@"%ld",tap.view.tag);
    //[self showImage:(UIImageView *)tap.view];
    
    UIImageView *savedImg=(id)tap.view;
    
    UIImageWriteToSavedPhotosAlbum(savedImg.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
    
}
-(void)showImage:(UIImageView *)imagV
{
    //将点击的图片赋值给要显示的图片
    _imgV=imagV;
    
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIImage *image=_imgV.image;
    
    originalImageRect=[_imgV convertRect:_imgV.bounds toView:window];
    
    container_scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    //container_scrollView.delegate=self;
    container_scrollView.maximumZoomScale=2.0;
    
    container_scrollView.contentSize=CGSizeMake(self.view.frame.size.width*9, self.view.frame.size.width);
    
    container_scrollView.pagingEnabled=YES;
    
//
    
    
    //container_view =[[UIView alloc]init];
    
    //container_view.frame=container_scrollView.frame;
    
    //container_view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    snapImg=(id)[_imgV snapshotViewAfterScreenUpdates:NO];
    
    //动画前的图片位置
    snapImg.frame=originalImageRect;
//    
//    for(int i=0;i<9;i++)
//    {
//        
//    }
    
    
    //[container_view addSubview:snapImg];
    [container_scrollView addSubview:snapImg];
    
    [window addSubview:container_scrollView];
    
    _imgV.alpha=0;
    container_scrollView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    //将图片移到中央
    
    CGFloat imageH=image.size.height;
    CGFloat rate=SCREEN_WIDTH/image.size.width;
    NSLog(@"rate===%f",rate);
    UITapGestureRecognizer *tapG=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImg:)];
    
    [container_scrollView addGestureRecognizer:tapG];
    
     CGRect finalRect=CGRectMake(0, (SCREEN_HEIGHT-image.size.height*rate)/2, SCREEN_WIDTH, imageH*rate);
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
       
        //for(int i=0;i<9;i++)
        //{
            //snapImg=[imagV viewWithTag:100+i];
           // CGRect finalRect=CGRectMake(SCREEN_WIDTH*i, (SCREEN_HEIGHT-image.size.height*rate)/2, SCREEN_WIDTH, imageH*rate);
            snapImg.frame=finalRect;
            container_scrollView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
            
            //[container_scrollView addSubview:snapImg];
            
            //[window addSubview:container_scrollView];
       // }
        

        
       
        
        
        
        
        
    } completion:^(BOOL finished) {
       
        NSLog(@"结束了!");
        
    }];


}
-(void)hideImg:(UITapGestureRecognizer *)sender
{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        container_scrollView.zoomScale=1.0f;
       
        snapImg.frame=originalImageRect;
         container_scrollView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        
        
    } completion:^(BOOL finished) {
        
        _imgV.alpha=1;
        [container_scrollView removeFromSuperview];
    }];
    
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
//-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//{
//    //return container_view;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
