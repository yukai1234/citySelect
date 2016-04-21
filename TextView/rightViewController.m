

//
//  rightViewController.m
//  TextView
//
//  Created by 俞凯 on 16/3/18.
//  Copyright © 2016年 俞凯. All rights reserved.
//

#import "rightViewController.h"
#import "AttributeStyle.h"
#import "NSString+AttributeStyle.h"
#import "provinceView.h"
@interface rightViewController ()

@end

@implementation rightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *checkBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    checkBtn.frame=CGRectMake(50, 60, 100, 100);
    [checkBtn setTitle:@"开始验货" forState:UIControlStateNormal];
    [checkBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    checkBtn.backgroundColor=[UIColor greenColor];
    [self.view addSubview:checkBtn];
    
    [checkBtn addTarget:self action:@selector(checkGoods:) forControlEvents:UIControlEventTouchUpInside];
        NSString *string=@"我的情况为你打开";
    //NSMutableAttributedString *attributeStr=[[NSMutableAttributedString alloc]initWithString:string];
    
    
    
    //[attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(50, 100, 200, 50)];
    lab.attributedText=[string creatNSAttributedStringByStyles:@[
                                                                 [AttributeStyle initWithAttributeName:NSForegroundColorAttributeName valeu:[UIColor redColor] rangge:NSMakeRange(0, 3)],
                                                                 [AttributeStyle initWithAttributeName:NSFontAttributeName valeu:[UIFont systemFontOfSize:15] rangge:NSMakeRange(2, 3)],
                                                                 [AttributeStyle initWithAttributeName:NSKernAttributeName  valeu:@(+7) rangge:NSMakeRange(0, 2)]]
                        
                        ];
    
    [self.view addSubview:lab];

}

-(void)checkGoods:(UIButton *)sender
{
    provinceView *pView=[[provinceView alloc]initWithFrame:CGRectMake(0, 94, 100, 300)];
    
    [self.view addSubview:pView];

}
-(void)firstAttrbut
{
    
}
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
