//
//  UIBarButtonItem+OYItem.h
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/18.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (OYItem)
+(UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action;
+(UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image selectImage:(UIImage *)selectImage target:(id)target action:(SEL)action;
+(UIBarButtonItem *)barButtonItemWithTitle:(NSString *)Str  target:(id)target action:(SEL)action;
@end
