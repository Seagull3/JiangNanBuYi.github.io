//
//  OYTitleButton.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/24.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "OYTitleButton.h"

@implementation OYTitleButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
    }
    return self ;
}

-(void)setHighlighted:(BOOL)highlighted{
    
}
@end
