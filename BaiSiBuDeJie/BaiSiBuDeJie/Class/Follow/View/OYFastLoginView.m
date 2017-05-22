//
//  OYFastLoginView.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/22.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "OYFastLoginView.h"

@implementation OYFastLoginView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)fastLoginView{
    return [[[NSBundle mainBundle]loadNibNamed:@"OYFastLoginView" owner:nil options:nil] lastObject];
}

@end
