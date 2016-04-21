//
//  NSString+AttributeStyle.m
//  TextView
//
//  Created by 俞凯 on 16/4/13.
//  Copyright © 2016年 俞凯. All rights reserved.
//

#import "NSString+AttributeStyle.h"
#import "AttributeStyle.h"
@implementation NSString (AttributeStyle)
-(NSAttributedString *)creatNSAttributedStringByStyles:(NSArray *)styles
{
    NSMutableAttributedString *aStr=[[NSMutableAttributedString alloc]initWithString:self];
    
    for(int count=0;count<styles.count;count++)
    {
        AttributeStyle *style=styles[count];//富文本样式
        
        [aStr addAttribute:style.attributName value:style.value range:style.range];
        
    }
    
    return aStr;
}
@end
