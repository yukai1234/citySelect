//
//  provinceModel.m
//  TextView
//
//  Created by 俞凯 on 16/4/20.
//  Copyright © 2016年 俞凯. All rights reserved.
//

#import "provinceModel.h"
@interface provinceModel()


@end


@implementation provinceModel

-(instancetype)init
{
    
    if(self=[super init])
    {
        
        NSString *path= [[NSBundle mainBundle]pathForResource:@"area" ofType:@".plist"];
        
        _area=[NSDictionary dictionaryWithContentsOfFile:path];
        
        
     
        self.provinceArr=[_area allKeys];
       
        
    }
    return self;
    
}

+(instancetype)initWithOne
{
    return [[self alloc]init];
}
-(void)setProvinceArr:(NSArray *)provinceArr
{
      _provinceArr=provinceArr;
}
-(void)setArea:(NSDictionary *)area
{
    _area=area;
}
@end
