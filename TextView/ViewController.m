//
//  ViewController.m
//  TextView
//
//  Created by 俞凯 on 16/3/16.
//  Copyright © 2016年 俞凯. All rights reserved.
//

#import "ViewController.h"
#import "SecViewController.h"
@interface ViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *greenTextView;
@property(nonatomic,strong)UIToolbar *toolBar;
@property(nonatomic,strong)UIImagePickerController *picker;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _greenTextView.layer.borderColor=[UIColor redColor].CGColor;
    _greenTextView.layer.borderWidth=5;
    _greenTextView.layer.cornerRadius=10;
    _greenTextView.clipsToBounds=YES;
    _greenTextView.scrollEnabled=YES;
    _greenTextView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    _picker=[[UIImagePickerController alloc]init];
    _picker.delegate=self;
    [self configToolBar];
}
- (IBAction)toNext:(id)sender {
    
    SecViewController *sec=[[SecViewController alloc]init];
    [self presentViewController:sec animated:YES
                     completion:nil];
}

-(void)configToolBar
{
    _toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 40)];
   
    _toolBar.backgroundColor=[UIColor grayColor];
    
    _greenTextView.inputAccessoryView=_toolBar;
    
    
    UIButton *picBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    picBtn.frame=CGRectMake(20, 10, 50, 20);
    [picBtn setTitle:@"照片" forState:UIControlStateNormal];
    
    [_toolBar addSubview:picBtn];
    [picBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)click:(UIButton *)sender
{
    [self.view endEditing:YES];
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册" ,nil];
    [sheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        _picker.sourceType=UIImagePickerControllerSourceTypeCamera;
    }
    else if (buttonIndex==1)
    {
        _picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else
    {
        return;
    }
    
    [self presentViewController:_picker animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *img=info[@"UIImagePickerControllerOriginalImage"];
    NSLog(@"%@",info);
    //NSMutableAttributedString *attributeStr=[[NSMutableAttributedString alloc]initWithAttributedString:_greenTextView.attributedText];
    
    NSTextAttachment *textAttachment=[NSTextAttachment new];
    textAttachment.image=img;
    textAttachment.bounds=CGRectMake(0, 0, _greenTextView.frame.size.width/2, _greenTextView.frame.size.width/2);
    [_greenTextView.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment] atIndex:_greenTextView.selectedRange.location];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillshow:) name:UIKeyboardWillShowNotification  object:nil];
}
-(void)keyboardWillshow:(NSNotification *)notification
{
    //_greenTextView.returnKeyType=UIReturnKeySend;
    CGRect bounds=self.view.bounds;
    if(bounds.origin.y<100)
    {
        bounds.origin.y+=300;
    }
    self.view.bounds=bounds;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    CGRect bounds=self.view.bounds;
    bounds.origin.y-=300;
    self.view.bounds=bounds;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
