
//
//  provinceView.m
//  TextView
//
//  Created by 俞凯 on 16/4/19.
//  Copyright © 2016年 俞凯. All rights reserved.
//

#import "provinceView.h"
#import "provinceModel.h"
#import "cityModel.h"
@interface provinceView()<UITableViewDelegate,UITableViewDataSource>

{
    NSInteger roww;
    
    NSInteger roww2;
}
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UITableView *table2;
@property(nonatomic,strong)UITableView *table3;
@property(nonatomic,strong)NSArray *provinArr;
@property(nonatomic,strong)NSArray *cityArr;
@property(nonatomic,strong)NSArray *townArr;
@property(nonatomic,strong)provinceModel*pModel;
@end

@implementation provinceView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        
        [self loadData];
        
        [self configUI];
        
    }
    return self;
}
-(void)loadData
{

    
   _pModel=[[provinceModel alloc]init];

    
    //前面为空，  后面必须有值  这样才能赋值
    _provinArr=_pModel.provinceArr;

//    cityModel *cModel=[[cityModel alloc]init];
//
//    _cityArr=cModel.cityArr;
   
    
}

-(void)configUI
{
    

    _table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/3, self.frame.size.height)];
  
    _table.delegate=self;
    _table.dataSource=self;
    
    [self addSubview:_table];
    
    _table2=[[UITableView alloc]initWithFrame:CGRectMake(_table.frame.size.width, 0, self.frame.size.width/3, self.frame.size.height)];
    
//    _table2.delegate=self;
//    _table2.dataSource=self;
    
    [self addSubview:_table2];
    
    _table3=[[UITableView alloc]initWithFrame:CGRectMake(_table.frame.size.width*2, 0 ,self.frame.size.width/3, self.frame.size.height)];
    
//    _table3.delegate=self;
//    _table3.dataSource=self;
    
    [self addSubview:_table3];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==self.table)
    {
         return _provinArr.count;
    }
    else if (tableView==self.table2)
    {
        _pModel=[provinceModel initWithOne];
        //        //取到省下面的市
        
        NSDictionary *cityDic= _pModel.area[_provinArr[roww]];
        
        
        
        _cityArr=[cityDic allKeys];
        
        return _cityArr.count;
        
        
    }
    else{
        if(roww2>_cityArr.count)
        {

            roww2=_cityArr.count-1;
        
        }
       
        
        _townArr= _pModel.area[_provinArr[roww]][_cityArr[roww2]];
        
        
    return _townArr.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static   NSString *cellId=@"cellid";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if(tableView==self.table)
    {
          if(!cell)
        {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
         }
    
        cell.textLabel.text=_provinArr[indexPath.row];
       
    }
 else if(tableView==self.table2)
    {
        if(!cell)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }


            cell.textLabel.text=_cityArr[indexPath.row];
        
        
    }
    else
    {
        if(!cell)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        cell.textLabel.text=_townArr[indexPath.row];
    }
    return  cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    if (tableView==self.table) {
        
    
    _table2.dataSource=self;
    _table2.delegate=self;
        
    roww=indexPath.row;
    [_table2 reloadData];
      
    //[_table3 reloadData];

    }
    if(tableView==self.table2)
    {
        _table3.dataSource=self;
        _table3.delegate=self;
        
        roww2=indexPath.row;
     
        [_table3 reloadData];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
