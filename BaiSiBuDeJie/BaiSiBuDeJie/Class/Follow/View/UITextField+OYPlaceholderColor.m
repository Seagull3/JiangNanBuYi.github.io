//
//  UITextField+OYPlaceholderColor.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/23.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "UITextField+OYPlaceholderColor.h"

@implementation UITextField (OYPlaceholderColor)
+(void)textFiledPlaceholderColor:(UIColor *)color textFiled:(UITextField *)text{
    
    UILabel *placeholderLabel = [text valueForKey:@"placeholderLabel"];
    
    placeholderLabel.textColor = color;
}
@end
