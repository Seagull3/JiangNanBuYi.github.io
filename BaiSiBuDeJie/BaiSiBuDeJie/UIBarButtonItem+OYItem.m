//
//  UIBarButtonItem+OYItem.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/18.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "UIBarButtonItem+OYItem.h"

@implementation UIBarButtonItem (OYItem)
+(UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:image forState:UIControlStateNormal];
    
    [btn setImage:highlightImage forState:UIControlStateHighlighted];
    
    [btn sizeToFit];
    
    [btn addTarget:target  action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *imageV = [[UIView alloc]initWithFrame:btn.bounds];

    
    [imageV addSubview:btn];
    
    
    return [[UIBarButtonItem alloc]initWithCustomView:imageV];
}
+(UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image selectImage:(UIImage *)selectImage target:(id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:image forState:UIControlStateNormal];
    
    [btn setImage:selectImage forState:UIControlStateSelected];
    
    [btn sizeToFit];
    
    [btn addTarget:target  action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *imageV = [[UIView alloc]initWithFrame:btn.bounds];
    
    
    [imageV addSubview:btn];
    
    
    return [[UIBarButtonItem alloc]initWithCustomView:imageV];
}
+(UIBarButtonItem *)barButtonItemWithTitle:(NSString *)Str  target:(id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitle:@"返回" forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    [btn sizeToFit];
    
    [btn addTarget:target  action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *imageV = [[UIView alloc]initWithFrame:btn.bounds];
    
    
    [imageV addSubview:btn];
    
    
    return [[UIBarButtonItem alloc]initWithCustomView:imageV];
}
@end
