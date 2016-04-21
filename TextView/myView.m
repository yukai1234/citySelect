

//
//  myView.m
//  TextView
//
//  Created by 俞凯 on 16/3/21.
//  Copyright © 2016年 俞凯. All rights reserved.
//

#import "myView.h"
#import "SDPhotoBrowser.h"
@interface myView()<SDPhotoBrowserDelegate>
@property (nonatomic, strong) NSArray *imageViewsArray;

@end

@implementation myView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        [self configUI];
    }
    return  self;
}
-(void)configUI
{
    //间距
    CGFloat Wjianju=20.0;
    
    
    //图片长宽
    CGFloat picW=(self.frame.size.width-2*Wjianju)/3;
    
    CGFloat picH=picW;
    
    CGFloat y=self.frame.size.height/2-picH;
    
    for(int i=0;i<3;i++)
    {
        for(int j=0;j<3;j++)
        {
            UIImageView *imgV=[[UIImageView alloc]initWithFrame:CGRectMake((Wjianju+picW)*i, y+(picH+Wjianju)*j, picW, picH)];
            imgV.tag=100+i+j*3;
            imgV.image=[UIImage imageNamed:[NSString stringWithFormat:@"00%d",i+j*3+1]];
            [self addSubview:imgV];
            imgV.userInteractionEnabled=YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapp:)];
            [imgV addGestureRecognizer:tap];
        }
    }

}
-(void)tapp:(UITapGestureRecognizer *)tap
{
    NSLog(@"%ld",tap.view.tag);
    SDPhotoBrowser *broser=[[SDPhotoBrowser alloc]init];
    broser.currentImageIndex=tap.view.tag;
    broser.sourceImagesContainerView=self;
    broser.delegate=self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
