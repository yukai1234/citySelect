
//
//  TirViewController.m
//  TextView
//
//  Created by 俞凯 on 16/3/18.
//  Copyright © 2016年 俞凯. All rights reserved.
//

#import "TirViewController.h"
#import "provinceView.h"
#import <CoreMotion/CoreMotion.h>
@interface TirViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    float startScrollPosition;
    float endScrollPosition;
    float willEndPosition;
}
@property(nonatomic,strong)UIView *gView;
@property(nonatomic,strong)UIDynamicAnimator *DA;
@property(nonatomic,strong)UIDynamicItemBehavior *DynamicItemBehavior;
@property(nonatomic,strong)UIView *blueView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UIScrollView *selectScroll;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UIButton *selectBtn;
@property(nonatomic,strong)NSArray *provinArr;
@property(nonatomic,strong)UITableView *selectTable;
@end

@implementation TirViewController
-(UIDynamicAnimator *)DA
{
    if(!_DA)
    {
        _DA=[[UIDynamicAnimator alloc]initWithReferenceView:self.view];
        
    }
    return  _DA;
}
-(UIDynamicItemBehavior *)DynamicItemBehavior
{
    if (!_DynamicItemBehavior) {
        
        _DynamicItemBehavior=[[UIDynamicItemBehavior alloc]initWithItems:@[self.gView]];
        _DynamicItemBehavior.elasticity=0.6;
        //_DynamicItemBehavior.friction=0.5;
        //_DynamicItemBehavior.resistance=0.5;
        
    }
    return _DynamicItemBehavior;
}
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+30, self.view.frame.size.width, self.view.frame.size.height-64-30)];
        //_scrollView.backgroundColor=[UIColor yellowColor];
        _scrollView.contentSize=CGSizeMake(self.view.frame.size.width*6, 0);
        _scrollView.pagingEnabled=YES;
        
        _scrollView.bounces=NO;
        
        _scrollView.alwaysBounceVertical=NO;
        
        _scrollView.alwaysBounceHorizontal=NO;
        _scrollView.contentOffset=CGPointMake(0, 0);
        _scrollView.delegate=self;
      
        //_scrollView.contentInset=UIEdgeInsetsMake(0,64, 0, 0);
        //[self.view addSubview:self.scrollView];
    }
    return _scrollView;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"滚动了");
    
    
   
}


-(void)lineMove:(NSNotification *)notify
{
    NSLog(@"监听到了");
    
    [UIView animateWithDuration:0.5 animations:^{
        
        //从左往右滑
        //endScrollPosition>startScrollPosition&&
        if(willEndPosition>startScrollPosition)
        {
            NSLog(@"向右滑了!");
            
            CGRect frame=_lineView.frame;
         
            frame.origin.x+=_gView.frame.size.width/6;
           
            _lineView.frame=frame;
            
            if(frame.origin.x>=(_gView.frame.size.width/6)*3)
            {
                CGRect frame1=_selectScroll.frame;
                
                frame1.origin.x-=30;
                _selectScroll.frame=frame1;
            }
            
        }
        if (willEndPosition<startScrollPosition) {
            NSLog(@"向左滑了!");
            
            CGRect frame=_lineView.frame;
            
            frame.origin.x-=_gView.frame.size.width/6;
            
            _lineView.frame=frame;
            if(frame.origin.x>=(_gView.frame.size.width/6)*2)
            {
                CGRect frame2=_selectScroll.frame;
                
                frame2.origin.x+=30;
                _selectScroll.frame=frame2;
            }
        }

        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"2sddsdsads");
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //NSLog(@"减速了");
    
    endScrollPosition=scrollView.contentOffset.x;
     NSLog(@"============%f",scrollView.contentOffset.x);
   
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    startScrollPosition=scrollView.contentOffset.x;
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    willEndPosition=scrollView.contentOffset.x;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"move" object:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.selectTable) {
        return _provinArr.count;
    }
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    NSString *cellId=@"papapa";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    
    if (tableView.tag==20000) {
        cell.textLabel.text=_provinArr[indexPath.row];
    }
    //cell.textLabel.text=[NSString stringWithFormat:@"夕阳%ld号",indexPath.row];
    
    cell.textLabel.text= _provinArr[indexPath.row];
        return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.selectTable) {
        return 40;
    }
    
    return 50;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(lineMove:) name:@"move" object:nil];
//  
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor=[UIColor redColor];
    
    btn.frame=CGRectMake(20,200, 30, 30);
    
    //[self.scrollView addSubview:btn];
    
  
    
    [self.view addSubview:self.scrollView];
    
    
    //[btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _gView=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 64, self.view.frame.size.width+60, 30)];
    _gView.backgroundColor=[UIColor grayColor];
    
     [self.view addSubview:_gView];
   
    NSArray *array=@[@"套餐",@"积分",@"办理",@"详单",@"订单",@"附近"];
    
    _selectScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width+60, 30)];
    
    _selectScroll.contentSize=CGSizeMake(_selectScroll.frame.size.width+60, 0);
    _selectScroll.showsHorizontalScrollIndicator=NO;
    
    _selectScroll.bounces=YES;
    
    CGFloat lineW=(_gView.frame.size.width/array.count)*0.3;
    
    
    
   _lineView=[[UIView alloc]initWithFrame:CGRectMake((_gView.frame.size.width/array.count)*0.35, 28, lineW, 2)];
    _lineView.backgroundColor=[UIColor whiteColor];
    
    [_selectScroll addSubview:_lineView];
    
    
    
    [_gView addSubview:_selectScroll];
    
    
    for(int i=0;i<6;i++)
    {
        UIButton *selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        
        
        [selectBtn setTitle:array[i] forState:UIControlStateNormal];
        
        selectBtn.tag=100+i;
        [selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [selectBtn setFrame:CGRectMake((_gView.frame.size.width/array.count)*i, 0, _gView.frame.size.width/array.count, 30)];
        //_selectBtn=selectBtn;
        
        
        [selectBtn addTarget:self action:@selector(clickOne:) forControlEvents:UIControlEventTouchUpInside];
        [_selectScroll addSubview:selectBtn];
    }
   
    
    
  [self creatTable];
    
    
    
   NSString *path= [[NSBundle mainBundle]pathForResource:@"area" ofType:@".plist"];
    NSDictionary *area=[NSDictionary dictionaryWithContentsOfFile:path];
    
   _provinArr=[area allKeys];
    //NSDictionary *proName=[area objectForKey:@"0"];
    
   //NSLog(@"-----------%@",area);
   
    
    
    
    
}
-(void)clickOne:(UIButton *)sender
{
    if(sender.tag==100)
    {
      
//        _selectTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+30, _selectBtn.frame.size.width, 300)];
//        _selectTable.tag=20000;
//        _selectTable.delegate=self;
//        _selectTable.dataSource=self;
//        _selectTable.backgroundColor=[UIColor redColor];
//        
//        [_selectTable reloadData];
//        [self.view addSubview:_selectTable];

        UIView *mask=[[UIView alloc]initWithFrame:_scrollView.bounds];
        
        mask.backgroundColor=[UIColor grayColor];
        
        //mask.alpha=0.4;
        
        [_scrollView addSubview:mask];
        
        provinceView *pView=[[provinceView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
        
        
        [mask addSubview:pView];
        
    }
    if(sender.tag==101)
    {
        NSLog(@"101");
    }
}
-(void)creatTable
{
    for(int i=0;i<6;i++)
    {
        _table=[[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*i, -64, self.view.frame.size.width, _scrollView.frame.size.height)];
        _table.backgroundColor=[UIColor yellowColor];
        _table.delegate=self;
        _table.dataSource=self;
        _table.tag=1000+i;
        [_scrollView addSubview:_table];
    }
}
//-(void)click:(UIButton *)sender
//{
//    [self testGravity];
//}

-(void)viewWillAppear:(BOOL)animated{
    [self testGravity];
}
-(void)testGravity
{
    
    
    
    UIGravityBehavior *gravity=[[UIGravityBehavior alloc]init];
    [gravity addItem:_gView];
    
    //_gView.transform=CGAffineTransformMakeRotation(M_PI*0.022);
    gravity.gravityDirection = CGVectorMake(-1,0);
    //设置重力的方向（角度）x 轴正方向为0点，顺时针为正，逆时针为负
  
    //gravity.angle =M_PI;
    //重力加速度
    gravity.magnitude = 1.5;
    
   // UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.gView,self.blueView]];
    
   UICollisionBehavior *collisionBehavior=[[UICollisionBehavior alloc]init];
    
    [collisionBehavior addItem:_gView];
    
    //撞墙边界
   [collisionBehavior addBoundaryWithIdentifier:@"gView" fromPoint:CGPointMake(0, 64) toPoint:CGPointMake(0, 300)];
   
    //设置碰撞边界，不设置就会飞出屏幕，设置就会在屏幕边框处产生碰撞效果
    //collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    //将碰撞行为加入物理仿真器
    
    
    [self.DA addBehavior:gravity];
    [self.DA addBehavior:collisionBehavior];
    [self.DA addBehavior:self.DynamicItemBehavior];
    
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
