//
//  OYFastLoginBtn.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/22.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "OYFastLoginBtn.h"

@implementation OYFastLoginBtn

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //设置图片的时候要注意 xib 中的mode 要改成center
    self.imageView.OY_centerX = self.OY_width * 0.5;
    self.imageView.OY_y = 0 ;
    
    [self.titleLabel sizeToFit];
    //首先要自适应lable  否则显示有问题
    self.titleLabel.OY_centerX = self.OY_width * 0.5;
    self.titleLabel.OY_y = self.OY_height  - self.titleLabel.OY_height -20;

}
@end
