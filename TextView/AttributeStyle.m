//
//  AttributeStyle.m
//  TextView
//
//  Created by 俞凯 on 16/4/13.
//  Copyright © 2016年 俞凯. All rights reserved.
//

#import "AttributeStyle.h"

@implementation AttributeStyle
/*
 attributeName   value   rangge
 
 */

+(instancetype)initWithAttributeName:(NSString *)attributeName valeu:(id)value rangge:(NSRange)range
{
    AttributeStyle *style=[[AttributeStyle alloc]init];
    
    style.attributName=attributeName;
    
    style.value=value;
    
    style.range=range;
    
    return style;
    
}
@end
