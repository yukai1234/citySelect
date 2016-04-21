//
//  AttributeStyle.h
//  TextView
//
//  Created by 俞凯 on 16/4/13.
//  Copyright © 2016年 俞凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttributeStyle : NSObject
@property(nonatomic,strong)NSString *attributName;
@property(nonatomic,strong)id value;
@property(nonatomic)NSRange range;


+(instancetype)initWithAttributeName:(NSString *)attributeName valeu:(id)value rangge:(NSRange)range;
@end
