//
//  OYTabBar.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/18.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "OYTabBar.h"
#import "BaisiBuDeJie.pch"

#define tabBarW self.bounds.size.width
#define tabBarH self.bounds.size.height


@interface OYTabBar()

@property(nonatomic,weak) UIButton    *plusBtn;
@property(nonatomic,weak) UIButton    *previousButton;
@end

@implementation OYTabBar

//添加按钮
-(UIButton *)plusBtn{
    
    if (_plusBtn == nil ) {
        
        //创建添加按钮  并设置图片
        UIButton *btn  =[UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        
        [btn sizeToFit];
        
        _plusBtn = btn ;
    
        
        [self addSubview:btn];
    }
    return _plusBtn;
}
    //布局plusBtn
-(void)layoutSubviews{
    [super layoutSubviews];
    NSInteger count  = self.items.count + 1;
    
    
    
    NSLog(@"%@",[self.items[0] class]);
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = tabBarW / count;
    CGFloat btnH = tabBarH;
    NSInteger i = 0;
   
    
    for (UIControl *tabBarBtn in self.subviews) {
        if ([tabBarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            if (i == 0 && self.previousButton == nil) {
                self.previousButton = (UIButton *)tabBarBtn;
            }
 
            if (i == 2 ) {
                i += 1;
            }
            btnX = i *btnW;
            tabBarBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            
            i++;
            [tabBarBtn addTarget:self action:@selector(tabBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    self.plusBtn.center = CGPointMake(tabBarW * 0.5, tabBarH* 0.5);
    
}
/**
 *  点击tabBarBtnClick的方法
 */

-(void)tabBarBtnClick:(UIControl *)tabBarButton{
    if (self.previousButton == tabBarButton){
    [[NSNotificationCenter defaultCenter]postNotificationName:OYTabBarRepeatClickNotification object:nil];
    }
    self.previousButton = (UIButton *)tabBarButton;
}
@end
