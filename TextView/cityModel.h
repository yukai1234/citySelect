//
//  cityModel.h
//  TextView
//
//  Created by 俞凯 on 16/4/20.
//  Copyright © 2016年 俞凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "provinceModel.h"
@interface cityModel : NSObject
@property(nonatomic,strong)NSArray *cityArr;
-(instancetype)initWithModel:(provinceModel *)model;
@end
