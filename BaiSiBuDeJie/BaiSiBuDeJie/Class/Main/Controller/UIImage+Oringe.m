//
//  UIImage+Oringe.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/17.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "UIImage+Oringe.h"

@implementation UIImage (Oringe)
+(UIImage *)imageWithOringeName:(NSString *)nameStr{
    
    UIImage *image = [UIImage imageNamed:nameStr];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
