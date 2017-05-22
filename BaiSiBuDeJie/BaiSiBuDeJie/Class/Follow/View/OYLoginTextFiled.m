//
//  OYLoginTextFiled.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/22.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "OYLoginTextFiled.h"
#import "UITextField+Placeholder.h"

@implementation OYLoginTextFiled
-(void)awakeFromNib{
    //光标的颜色
    
//     placeholderLabel
    self.tintColor  = [UIColor whiteColor];
    [self addTarget:self action:@selector(textBegin) forControlEvents:  UIControlEventEditingDidBegin ];
     [self addTarget:self action:@selector(textEnd) forControlEvents:  UIControlEventEditingDidEnd ];
    
    self.placeholderColor = [UIColor lightGrayColor];
}
//现在是要改变textfiled的颜色 以及文本的内容
//首先要获取它的属性
-(void)textBegin{
    self.placeholderColor = [UIColor whiteColor];
    
    }
-(void)textEnd{
    
     self.placeholderColor = [UIColor grayColor];
}

@end
