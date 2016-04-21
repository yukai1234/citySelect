//
//  provinceModel.h
//  TextView
//
//  Created by 俞凯 on 16/4/20.
//  Copyright © 2016年 俞凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface provinceModel : NSObject
@property(nonatomic,strong)NSArray *provinceArr;
@property(nonatomic,strong) NSDictionary *area;
-(instancetype)initWithArray:(NSArray *)array;
+(instancetype)initWithOne;
@end
